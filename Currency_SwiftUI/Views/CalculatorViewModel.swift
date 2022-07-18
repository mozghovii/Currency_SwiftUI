//
//  CurrencyViewModel.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

final class CalculatorViewModel: ObservableObject {
    @Published var currencies: [CurrencyViewModel]?
    @Published var selectedCurrency: CurrencyViewModel? {
        didSet {
            calculated()
            saveToStorage()
        }
    }

    @Published var selectedDate = Date() {
        didSet {
            loadCurrencies()
        }
    }
    
    @Published var amount: String = "" {
        didSet {
            calculated()
        }
    }
    
    @Published var resultAmount: String = ""

    private let service = CurrencyService()
    
    init() {
        loadCurrencies()
    }
    
    private func loadCurrencies() {
        Task{
            let responseData = await service.loadCurrencies(selectedDate)
            switch responseData {
            case .success(let response):
                await MainActor.run {
                    currencies = response.compactMap({CurrencyViewModel.from($0)})
                    selectedCurrency = currencies?.first
                }
            case .failure:
                return
            }

        }
    }
    
    private func calculated() {
        if let amount = Double(amount), let currency = selectedCurrency {
            resultAmount = String(format: "%.2f %@", amount * currency.rate, currency.currencySymbol)
        } else {
            resultAmount = "0"
        }
    }
    
    private func saveToStorage() {
        guard let selectedCurrency = selectedCurrency else {
            return
        }
        HistoryManager.appendHistory(HistoryViewModel(model: selectedCurrency, date: Date(), id: Int.random(in: 0...1000)))
    }
    
}
