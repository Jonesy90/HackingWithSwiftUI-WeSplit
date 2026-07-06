//
//  ContentView.swift
//  HackingWithSwiftUI-WeSplit
//
//  Created by Michael Jones on 24/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ModelView()
    
    @FocusState private var amountIsFocused
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Amount", value: $viewModel.checkAmount, format: .currency(code: viewModel.currencyCode)) /// The Locale (iOS Struct) is used to get the users settings. Here I'm attempting to read the currency code the user has on their device. If they do not have one, default to the currency code of "GBP".
                        .keyboardType(.decimalPad) /// When the 'TextField' above is pressed, it open the keyboardType of decimalPad. Makes it a smoother experience for the user.
                        .focused($amountIsFocused) /// This allows SwiftUI to be silently aware when the TextField is receiving focus or not.
                    
                    Picker("Number of People:", selection: $viewModel.numberOfPeople) {
                        ForEach(2..<15) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink) /// Another PickerStyle option to use. This is using 'navigationLink' so it would require a 'NavigationStack' to be embedded around the Form.
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $viewModel.tipPercentage) {
                        ForEach(viewModel.tipsPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount") {
                    Text(viewModel.totalAmount, format: .currency(code: viewModel.currencyCode))
                        .foregroundStyle(viewModel.tipPercentage == 0 ? .red : .black)
                }
                
                Section("Amount per Person") {
                    Text(viewModel.totalPerPerson, format: .currency(code: viewModel.currencyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                /// Dismisses the keyboard when the 'Done' button is pressed. This is actioned when the 'amountIsFocused' @FocusState property is switched to false.
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
