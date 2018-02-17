//
//  Wallet.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class Wallet {

    private(set) var currencies: [String: Double]

    init(currencies: [String: Double]) {
        self.currencies = currencies
    }

    func hasAtLeast(funds: Double, ofCurrencyAcronym acronym: String) -> Bool {
        guard let walletCurrencyAmmount = self.currencies[acronym] else {
            return false
        }
        return walletCurrencyAmmount >= funds
    }

    func add(ammount: Double, forCurrencyAcronym acronym: String) {
        let walletCurrencyAmmount: Double
        if let currencyAmmount = self.currencies[acronym] {
            walletCurrencyAmmount = currencyAmmount
        } else {
            walletCurrencyAmmount = 0.0
        }
        self.currencies[acronym] = walletCurrencyAmmount + ammount
    }

    func subtract(ammount: Double, ofCurrencyAcronym acronym: String) {
        self.add(ammount: ammount * -1, forCurrencyAcronym: acronym)
    }
}
