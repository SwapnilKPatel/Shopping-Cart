//
//  CurrencyHelper.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation

class CurrencyHelper {
    var currency = Currency(quotes: ["INR":1], timestamp: 0)
    var selectedCurrency: String = "INR"
}

extension CurrencyHelper {
    
    func totalInCurrency(name: String, for total: Float) -> Float {
        self.selectedCurrency = name
        guard let rate = currency.quotes["INR"+name] else { return total }
        return total * rate
    }
    
    func display(total: Float) -> String {
        let newTotal = totalInCurrency(name: selectedCurrency, for: total)
        return String(format: "%.2f", newTotal) + " " + selectedCurrency
    }
}

