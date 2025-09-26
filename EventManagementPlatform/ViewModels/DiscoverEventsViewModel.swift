import Foundation
import Combine

enum State1 {
    case loading
    case ui
    case error
}

enum FilterType: String, CaseIterable, Identifiable {
    case date = "Date"
    case category = "Category"
    var id: String { self.rawValue }
}

@MainActor
class DiscoverEventsViewModel : ObservableObject {
    @Published var items : DiscoverEventsModel?
    @Published var categoryItems : EventCategoriesModel?
    @Published var state : State1 = State1.loading
    @Published var searchedText : String = ""
    @Published private(set) var filteredAll: [Result] = []
    @Published private(set) var visible: [Result] = []
    private let pageSize = 20
    private var isLoadingMore = false
    var all: [Result] { items?.data.results ?? [] }
    @Published var filterType: FilterType = .date
    @Published var selectedCategory: String? = nil
    @Published var startDate: Date? = nil
    @Published var endDate: Date? = nil
    
    
    func fetchItems() async throws {
        
        state = .loading
        guard let url = URL(string:"http://18.208.147.119/events") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            reusableDateDecoder(decoder:decoder)
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let items = try decoder.decode(DiscoverEventsModel.self, from: data)
                    
                    self.items = items
                    self.state = .ui
                    print("items \(items)")
                    applyFilter()
                }
                else {
                    self.state = .error
                }
            }
            
            
        } catch let error {
            print("error \(error)")
            self.state = .error
            throw error
        }
    }
    
    func fetchCategoryItems() async throws {
        
        
        guard let url = URL(string:"http://18.208.147.119/event-categories") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            reusableDateDecoder(decoder:decoder)
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let items = try decoder.decode(EventCategoriesModel.self, from: data)
                    
                    self.categoryItems = items
                    print("items are \(items)")
                }
                else {
                    self.state = .error
                }
            }
            
            
        } catch let error {
            print("error \(error)")
            self.state = .error
            throw error
        }
    }
    
    
    func applyFilter() {
        let trimmed = searchedText.trimmingCharacters(in: .whitespacesAndNewlines)
        var base = trimmed.isEmpty
            ? all
            : all.filter { $0.eventName.localizedCaseInsensitiveContains(trimmed) }
        
        
        if let selectedCategory = selectedCategory {
            base = base.filter { $0.eventCategory == selectedCategory }
            print("data is \(selectedCategory) and \(base.count)")
        }
        
        switch filterType {
        case .date:
            base = base.sorted { $0.eventDate < $1.eventDate }
        case .category:
            base = base.sorted { $0.eventCategory < $1.eventCategory }
        }
        
        filteredAll = base
        visible = Array(filteredAll.prefix(pageSize))
    }

    func loadMoreIfNeeded(currentItem: Result) {
        guard let last = visible.last, last.eventID == currentItem.eventID else { return }
        guard visible.count < filteredAll.count, !isLoadingMore else { return }

        isLoadingMore = true
        let nextEnd = min(visible.count + pageSize, filteredAll.count)
        if visible.count < nextEnd {
            visible.append(contentsOf: filteredAll[visible.count..<nextEnd])
        }
        isLoadingMore = false
    }
    
}
