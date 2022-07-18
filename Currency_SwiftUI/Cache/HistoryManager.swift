//
//  HistoryManager.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation

enum Constants: Int {
    case batchSize = 10
}

class HistoryManager {
    enum Keys: String {
        case model
    }
    
    private static let storageContainer = UserDefaults()

    static var isEmpty: Bool {
        return getHistory().isEmpty
    }
    
    static func getHistory(_ batchSize: Int = Constants.batchSize.rawValue) -> [HistoryViewModel] {
        guard let data = storageContainer.object(forKey: Keys.model.rawValue) as? Data else {
            return []
        }
        
        do {
            let data = try JSONDecoder().decode([HistoryViewModel].self, from: data).prefix(batchSize)
            return Array(data)
        } catch {
            return []
        }
    }
    
    static func appendHistory(_ model: HistoryViewModel) {
        
        var models = getHistory()
        models.insert(model, at: 0)
        do {
            let data = try JSONEncoder().encode(models)
            storageContainer.set(data, forKey: Keys.model.rawValue)
        } catch {
            print(error)
        }
    }
    
    static func removeAll() {
        storageContainer.removeObject(forKey: Keys.model.rawValue)
        storageContainer.synchronize()
    }
}

