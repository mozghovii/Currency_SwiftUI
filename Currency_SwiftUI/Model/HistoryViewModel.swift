//
//  HistoryViewModel.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

struct HistoryViewModel: Codable, Identifiable {
    var model: CurrencyViewModel
    let date: Date
    let id: Int
}
