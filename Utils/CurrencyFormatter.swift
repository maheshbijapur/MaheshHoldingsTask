//
//  CurrencyFormatter.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import Foundation

enum CurrencyFormatter {

    static func format(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₹"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true

        return formatter.string(from: NSNumber(value: value)) ?? "₹0.00"
    }
}
