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
                                     ofCurrencyAcronym: buyingCurrency.basedOnAcronym) else {
                                        throw TransactionError.notEnoughFunds(ofCurrency: buyingCurrency.basedOnAcronym)
        }

        try self.wallet.add(ammount: ammount, forCurrencyAcronym: buyingCurrency.acronym,
                            withName: buyingCurrency.name)
        try self.wallet.subtract(ammount: neededBasedOnCurrencyAmmount,
                             ofCurrencyAcronym: buyingCurrency.basedOnAcronym,
                             withName: buyingCurrency.basedOnName)

        return self.wallet
    }
    
    // criar um metodo para dar rollback na transacao
}
