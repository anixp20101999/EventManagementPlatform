//
//  GlobalFunctions.swift
//  EventManagementPlatform
//
//  Created by Mansi Laad on 25/09/25.
//

import Foundation
import SwiftUI

func reusableDateDecoder(decoder:JSONDecoder){
    
    decoder.dateDecodingStrategy = .custom({ decoder in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        let formats = ["yyyy-MM-dd'T'HH:mm:ssZ","yyyy-MM-dd'T'HH:mm:ss.SSS'Z'","yyyy-MM-dd'T'HH:mm:ss","dd-MM-yyyy"]
        for format in formats {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        throw DecodingError.dataCorruptedError(in: container,
                                               debugDescription: "Cannot decode date string \(dateString)")
    })
    
}

func formatDate(from isoString: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    
    // Parse ISO string to Date
    guard let date = isoFormatter.date(from: isoString) else { return isoString }
    
    // Format to "MMM d, yyyy"
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter.string(from: date)
}

struct Loader: View {
    var width : CGFloat?
    var height : CGFloat?
    var tint: Color?

    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: tint ?? .black))
                .frame(width: width ?? 100 , height: height ?? 100)
        }}}


struct RoundedCorner: Shape {
    var radius: CGFloat = 20
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
