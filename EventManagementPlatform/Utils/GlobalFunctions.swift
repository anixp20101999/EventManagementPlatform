//
//  GlobalFunctions.swift
//  EventManagementPlatform
//
//  Created by Mansi Laad on 25/09/25.
//

import Foundation

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
