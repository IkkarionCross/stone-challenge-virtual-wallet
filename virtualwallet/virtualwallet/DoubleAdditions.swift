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
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        return formatter.string(from: NSNumber(floatLiteral: Double(self))) ?? "\(self)"
    }
}
