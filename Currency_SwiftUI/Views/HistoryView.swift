//
//  HistoryView.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import SwiftUI

struct HistoryView: View {
    @State var isDoneTapped = false

    var body: some View {
        NavigationView {
            List {
                ForEach(HistoryManager.getHistory()) { history in
                    Text("\(history.date) - \(history.model.name)")
                }
            }
            
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Calculator") {
                        isDoneTapped = true
                    }
                    .overlay(NavigationLink(destination: CalculatorView(), isActive: $isDoneTapped) {
                    })
                }
            }
 
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
