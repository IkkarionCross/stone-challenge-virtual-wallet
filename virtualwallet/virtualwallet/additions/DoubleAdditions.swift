//
//  DoubleAdditions.swift
//  virtualwallet
//
//  Created by victor-mac on 19/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

extension Double {
    func currencyString() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale
        return formatter.string(from: NSNumber(floatLiteral: Double(self))) ?? "\(self)"
    }

    func currencyString(withSymbol symbol: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyDecimalSeparator = "."
        formatter.currencyGroupingSeparator = ","
        formatter.currencySymbol = symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))
    }
}
