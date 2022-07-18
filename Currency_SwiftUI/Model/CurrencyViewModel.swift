//
//  CurrencyViewModel.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

struct CurrencyViewModel: Codable, Identifiable {
    let name: String
    let rate: Double
    let symbol: String
    let id: Int
    
    static func from(_ currnecy: Currency) -> CurrencyViewModel? {
        return CurrencyViewModel(name: currnecy.txt,
                                 rate: currnecy.rate,
                                 symbol: currnecy.cc,
                                 id: currnecy.r030)
    }
}


extension CurrencyViewModel {
    
    var currencySymbol: String {
        return getSymbolForCurrencyCode() ?? ""
    }
    
    private func getSymbolForCurrencyCode() -> String? {
      let locale = NSLocale(localeIdentifier: symbol)
      return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: symbol)
    }
}
