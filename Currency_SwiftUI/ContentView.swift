//
//  ContentView.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if HistoryManager.isEmpty {
            CalculatorView()
        } else {
            HistoryView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
