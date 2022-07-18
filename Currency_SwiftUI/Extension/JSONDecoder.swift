//
//  JSONDecoder.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

enum DateError: String, Error {
    case invalidDate
}

extension JSONDecoder {
    
    static func apiJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        
        // date decode
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
    
            
            // current timezone
            formatter.dateFormat = "dd.mm.yyyy"
            formatter.timeZone = TimeZone.current
            
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            throw DateError.invalidDate
        })
        
        // from snake case
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
