import Foundation

// MARK: - DiscoverEventsModel
struct DiscoverEventsModel: Codable {
    let status, message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let numPages, count, totalCount: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case numPages = "num_pages"
        case count
        case totalCount = "total_count"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let eventID, eventName, eventDate: String
    let eventImageURL: String
    let longitude, latitude: Double
    let eventCategoryID, eventCategory: String
    let ticketPrice: Double

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case eventName = "event_name"
        case eventDate = "event_date"
        case eventImageURL = "event_image_url"
        case longitude, latitude
        case eventCategoryID = "event_category_id"
        case eventCategory = "event_category"
        case ticketPrice = "ticket_price"
    }
}
