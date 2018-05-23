//
//  CurrencyFieldDelegate.swift
//  virtualwallet
//
//  Created by victor-mac on 22/05/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class CurrencyFieldDelegate: NSObject, UITextFieldDelegate {
    private var symbol: String

    init(currencySymbol: String) {
        self.symbol = currencySymbol
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText: String = textField.text ?? ""
        textField.text = self.applyCurrencyFormat(oldText: oldText,
                                 usingCurrencySymbol: self.symbol,
                                 forRange: range, withNewString: string)
        return false
    }

    private func applyCurrencyFormat(oldText: String, usingCurrencySymbol symbol: String,
                                     forRange range: NSRange, withNewString string: String) -> String? {
        let oldText: NSString = NSString(string: oldText)
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        var newTextString = String(describing: newText)

        let digits = NSCharacterSet.decimalDigits
        var digitText = ""
        for unicodeScalar in newTextString.unicodeScalars {
            if digits.contains(unicodeScalar) {
                guard let char = UnicodeScalar(unicodeScalar.value) else {
                    continue
                }
                digitText.append(String(describing: char))
            }
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.currencySymbol = symbol
        let numberFromField = (NSString(string: digitText).doubleValue)/100

        return formatter.string(from: NSNumber(value: numberFromField))
    }
}
