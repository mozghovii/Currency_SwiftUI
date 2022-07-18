//
//  GetCurrencyList.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation
import Alamofire

struct GetCurrencyList: APIRequest {
    
    typealias Response = [Currency]
    
    var path: String {
        return "/exchange?json"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var date: String
    
    init(with date: String) {
        self.date = date
    }
}
