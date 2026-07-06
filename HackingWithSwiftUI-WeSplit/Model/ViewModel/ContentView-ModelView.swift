//
//  ContentView-ModelView.swift
//  HackingWithSwiftUI-WeSplit
//
//  Created by Michael Jones on 06/07/2026.
//

import Foundation

extension ContentView {
    @Observable
    class ModelView {
        var checkAmount = 0.0 /// The amount of money that is due to be paid.
        var numberOfPeople = 2 /// The number of people that will split the cost of the 'checkAmount'.
        var tipPercentage = 20 /// The tip percentage that is going to be added on the top of the 'checkAmount'.
        
        var tipsPercentages = [10, 15, 20, 25, 0] // [Int] of available tip percentages.
        
        let currencyCode = Locale.current.currency?.identifier ?? "GBP"
        
        var totalAmount: Double {
            let tipSelection = Double(tipPercentage) /// Converts the tipPercentage into a Double, it can be used with the rest of the 'totalPercentage' computed property.
            let tipValue = (checkAmount / 100) * tipSelection /// Returns the total tip amount that needs to be added onto the 'checkAmount'.
            return checkAmount + tipValue
        }
        
        var totalPerPerson: Double {
            let peopleCount = Double(numberOfPeople + 2)
            let amountPerPerson = totalAmount / peopleCount /// Dividing the total amount due by the amount of people.
            return amountPerPerson
        }
    }
}
