import Foundation
import Combine

@MainActor
class EventDetailsViewModel : ObservableObject {
    @Published var items : EventDetailsModel?
    @Published var state : State = State.loading
    
    func fetchItems(id:String) async throws {
        
        state = .loading
        guard let url = URL(string:"http://18.208.147.119/events/\(id)") else {
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
                    let items = try decoder.decode(EventDetailsModel.self, from: data)
                    
                    self.items = items
                    self.state = .ui
                    print(" detail items \(items)")
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
