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
        var acronym: String
        var value: Double
        var name: String
    }

    private(set) var currencies: [CurrencyValue]

    init(currencies: [CurrencyValue]) {
        self.currencies = currencies
    }

    func currency(forAcronym acronym: String) -> CurrencyValue? {
        return self.currencies.filter({
            $0.acronym == acronym
        }).first
    }

    func currency(forIndex index: Int) -> CurrencyValue? {
        if index >= self.currencies.count {
            return nil
        }
        return self.currencies[index]
    }

    func hasAtLeast(funds: Double, ofCurrencyAcronym acronym: String) -> Bool {
        guard let walletCurrencyAmmount = self.currency(forAcronym: acronym)?.value else {
            return false
        }
        return walletCurrencyAmmount >= funds
    }

    func add(ammount: Double, forCurrencyAcronym acronym: String, withName name: String) {
        let walletCurrencyAmmount: Double
        if let currency = self.currency(forAcronym: acronym) {
            walletCurrencyAmmount = currency.value
        } else {
            walletCurrencyAmmount = 0.0
        }
        if let index: Int = self.currencies.index(where: { $0.acronym == acronym }) {
            self.currencies.remove(at: index)
        }
        let newCurrencyValue: CurrencyValue = CurrencyValue(acronym: acronym,
                                                            value: walletCurrencyAmmount + ammount, name: name)
        self.currencies.append(newCurrencyValue)
    }

    func subtract(ammount: Double, ofCurrencyAcronym acronym: String, withName name: String) {
        self.add(ammount: ammount * -1, forCurrencyAcronym: acronym, withName: name)
    }
}
