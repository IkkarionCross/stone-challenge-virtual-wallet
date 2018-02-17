//
//  CurrencyTransaction.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct CurrencyTransaction {
    private var wallet: Wallet

    init(withWallet wallet: Wallet) {
        self.wallet = wallet
    }

    func buy(ammount: Double, ofCurrency buyingCurrency: CurrencyProperties) throws -> Wallet {
        let neededBasedOnCurrencyAmmount: Double = ammount * buyingCurrency.buyPrice
        guard self.wallet.hasAtLeast(funds: neededBasedOnCurrencyAmmount,
                                     ofCurrencyAcronym: buyingCurrency.basedOnCurrencyAcronym) else {
                                        throw TransactionError.notEnoughFunds(ofCurrency: buyingCurrency.acronym)
        }

        self.wallet.add(ammount: ammount, forCurrencyAcronym: buyingCurrency.acronym)
        self.wallet.subtract(ammount: neededBasedOnCurrencyAmmount,
                             ofCurrencyAcronym: buyingCurrency.basedOnCurrencyAcronym)

        return self.wallet
    }
}
