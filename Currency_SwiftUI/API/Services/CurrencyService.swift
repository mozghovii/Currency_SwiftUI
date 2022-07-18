//
//  CurrencyService.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

struct CurrencyService: API {
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let baseURL: String = "https://bank.gov.ua/NBUStatService/v1/statdirectory"
    
    func loadCurrencies(_ date: Date) async -> ResultCallback<GetCurrencyList.Response> {

        let request = GetCurrencyList(with: date.serverFormatted)
            do{
               let responseData = try await send(request)
                return responseData
            }catch{
                // HANDLE ERROR
                return .failure(error)
            }
    }
}
