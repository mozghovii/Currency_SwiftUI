//
//  Currency.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

struct Currency: Decodable {
    let txt: String
    let rate: Double
    let cc: String
    let exchangedate: Date
    let r030: Int
}
