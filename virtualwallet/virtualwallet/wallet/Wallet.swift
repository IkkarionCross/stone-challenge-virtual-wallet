//
//  Wallet.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class Wallet {
    struct CurrencyValue {
        var name: String
        var value: Double
    }

    private(set) var currencies: [CurrencyValue]

    init(currencies: [CurrencyValue]) {
        self.currencies = currencies
    }

    func currency(forAcronym acronym: String) -> CurrencyValue? {
        return self.currencies.filter({
            $0.name == acronym
        }).first
    }

    func hasAtLeast(funds: Double, ofCurrencyAcronym acronym: String) -> Bool {
        guard let walletCurrencyAmmount = self.currency(forAcronym: acronym)?.value else {
            return false
        }
        return walletCurrencyAmmount >= funds
    }

    func add(ammount: Double, forCurrencyAcronym acronym: String) {
        let walletCurrencyAmmount: Double
        if let currency = self.currency(forAcronym: acronym) {
            walletCurrencyAmmount = currency.value
        } else {
            walletCurrencyAmmount = 0.0
        }
        if let index: Int = self.currencies.index(where: { $0.name == acronym }) {
            self.currencies.remove(at: index)
        }
        let newCurrencyValue: CurrencyValue = CurrencyValue(name: acronym,
                                                            value: walletCurrencyAmmount + ammount)
        self.currencies.append(newCurrencyValue)
    }

    func subtract(ammount: Double, ofCurrencyAcronym acronym: String) {
        self.add(ammount: ammount * -1, forCurrencyAcronym: acronym)
    }
}
