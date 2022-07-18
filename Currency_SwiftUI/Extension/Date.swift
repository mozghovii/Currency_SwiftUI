//
//  Date.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

extension Date {
    var serverFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyyMMdd"  ///2022-06-02
        return dateFormatter.string(from: self)
    }
}
