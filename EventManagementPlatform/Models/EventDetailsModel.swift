import Foundation

// MARK: - EventDetailsModel
struct EventDetailsModel: Codable {
    let status, message: String
    let data: DetailsClass
}

// MARK: - DataClass
struct DetailsClass: Codable {
    let eventID, eventName, eventDescription, eventDate: String
    let eventImageUrls: [String]
    let longitude, latitude: Double
    let eventCategoryID, eventCategory: String
    let numAttendees: Int
    let ticketPrice: Double
    let organizerContact: String

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case eventName = "event_name"
        case eventDescription = "event_description"
        case eventDate = "event_date"
        case eventImageUrls = "event_image_urls"
        case longitude, latitude
        case eventCategoryID = "event_category_id"
        case eventCategory = "event_category"
        case numAttendees = "num_attendees"
        case ticketPrice = "ticket_price"
        case organizerContact = "organizer_contact"
    }
}
