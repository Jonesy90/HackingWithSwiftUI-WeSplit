//
//  ContentView.swift
//  HackingWithSwiftUI-WeSplit
//
//  Created by Michael Jones on 24/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0 //The amount of money that is due to be paid.
    @State private var numberOfPeople = 2 //The number of people that will split the cost of the 'checkAmount'.
    @State private var tipPercentage = 20 //The tip percentage that is going to be added on top of the 'checkAmount'.
    
    @FocusState private var amountIsFocused
    
    var tipsPercentages = [10, 15, 20, 25, 0] //A Int Array of available tip percentages.
    
    let currencyCode = Locale.current.currency?.identifier ?? "GBP"
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) //TODO: Explain this bit.
        let tipSelection = Double(tipPercentage) //Converts the tipPercentage into a Double so it can be used with the rest of the 'totalPercentage' computed property.
        
        let tipValue = (checkAmount / 100) * tipSelection //Returns the total tip amount that needs to be added onto the 'checkAmount'.
        let totalAmount = checkAmount + tipValue //Adding 'checkAmount' and 'tipValue' together to get the total amount due.
        let amountPerPerson = totalAmount / peopleCount //Dividing the total amount due by the amount of people.
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: currencyCode)) //The Locale (iOS Struct) is used to get the users settings. Here I'm attempting to read the currency code the user has on their device. If they do not have one, default to the currency code of "GBP".
                        .keyboardType(.decimalPad) //When the 'TextField' above is pressed, it open the keyboardType of decimalPad. Makes it a smoother experience for the user.
                        .focused($amountIsFocused) //This allows SwiftUI to be silently aware when the TextField is receiving focus or not.
                    
                    Picker("Number of People:", selection: $numberOfPeople) {
                        ForEach(2..<15) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink) //Another PickerStyle option to use. This is using 'navigationLink' so it would require a 'NavigationStack' to be embedded around the Form.
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipsPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                //Dismisses the keyboard when the 'Done' button is pressed. This is actioned when the 'amountIsFocused' @FocusState property is switched to false.
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
