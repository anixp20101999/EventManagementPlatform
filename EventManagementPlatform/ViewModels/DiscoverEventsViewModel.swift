import Foundation
import Combine

enum State {
    case loading
    case ui
    case error
}

@MainActor
class DiscoverEventsViewModel : ObservableObject {
    @Published var items : DiscoverEventsModel?
    @Published var state : State = State.loading
    @Published var searchedText : String = ""
    @Published private(set) var filteredAll: [Result] = []   // full filtered set
    @Published private(set) var visible: [Result] = []        // what UI shows (paged)
    private let pageSize = 10
    private var isLoadingMore = false
    private var all: [Result] { items?.data.results ?? [] }
    
    
    
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
                    applyInitialData()
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
    
    func applyInitialData() {
        filteredAll = all
        visible = Array(filteredAll.prefix(pageSize))
    }

    func updateSearch(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        filteredAll = trimmed.isEmpty
            ? all
            : all.filter { $0.eventName.localizedCaseInsensitiveContains(trimmed) }
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
