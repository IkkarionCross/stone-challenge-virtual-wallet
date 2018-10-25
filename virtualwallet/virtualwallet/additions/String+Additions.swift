//
//  String+Additions.swift
//  virtualwallet
//
//  Created by victor-mac on 17/09/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

extension String {
    func currencyStringToDouble(currencySymbol symbol: String) -> Double {
        if self == "" { return 0 }

        let format: NumberFormatter = NumberFormatter()
        format.numberStyle = .currency
        format.currencyDecimalSeparator = "."
        format.currencyGroupingSeparator = ","
        format.currencySymbol = symbol
        return format.number(from: self)?.doubleValue ?? 0
    }
}
