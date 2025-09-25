import Foundation


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
    
}
