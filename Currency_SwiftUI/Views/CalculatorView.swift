//
//  CurrencyView.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import SwiftUI

struct CalculatorView: View {
    
    @Namespace var animation
    
    @StateObject var viewModel: CalculatorViewModel = CalculatorViewModel()
    
    var body: some View {
        VStack {
            DateControl()
            
            CurrencyList()
            
            Text("Курс: \(viewModel.selectedCurrency?.rate ?? 0.0)")
                .padding(14)
            
            HStack {
                TextField("Сумма", text: $viewModel.amount)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                Text("Гривня")
                    .frame(maxWidth: 200)
            } .padding()
            
            Text("Результат: \(viewModel.resultAmount)")
                .fixedSize()
        }
    }
    
    @ViewBuilder
    func CurrencyList() -> some View {
        Menu {
            ForEach(viewModel.currencies ?? [] ) { currency in
                Button(currency.name) {
                    viewModel.selectedCurrency = currency
                }
            }
        } label: {
            if let selectedCurrencyName = viewModel.selectedCurrency?.name {
                Text(selectedCurrencyName)
                    .foregroundColor(Color("black_title"))
                    .font(.system(size: 20))
                    .padding(4)
                    .fixedSize()
                    .background {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.gray.opacity(0.25))
                    }
            } else {
                ProgressView()
                    .frame(minWidth: 300)
            }
        }
    }
    
    @ViewBuilder
    func DateControl() -> some View {
        DatePicker(selection: $viewModel.selectedDate ,in: ...Date(), displayedComponents: .date) {
            
        }
        .id(viewModel.selectedDate)
        .fixedSize()
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
