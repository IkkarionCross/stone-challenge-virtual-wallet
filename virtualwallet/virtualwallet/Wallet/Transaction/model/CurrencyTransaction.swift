//
//  CurrencyTransaction.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum TransactionType: Int {
    case buy = 0, sell = 1

    var description: String {
        switch self {
        case .buy:
            return "Comprar"
        case .sell:
            return "Vender"
        }
    }
}

struct CurrencyTransaction {
    private var wallet: WalletEntity

    init(withWallet wallet: WalletEntity) {
        self.wallet = wallet
    }

    func convert(amount: Double, toCurrency: CurrencyProperties) -> Double {
        return amount / toCurrency.buyPrice
    }

    func buy(ammount: Double, ofCurrency buyingCurrency: CurrencyProperties) throws -> WalletEntity {
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

}
