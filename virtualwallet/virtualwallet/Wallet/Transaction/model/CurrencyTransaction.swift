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

    func convert(amount: Double,
                 quotation: QuotationEntity, useInverted: Bool) -> Double {
        if useInverted {
            return (amount * quotation.invertedBuyPrice)
        } else {
            return (amount * quotation.buyPrice)
        }
    }

    func buy(ammount: Double, ofCurrency buyingCurrency: QuotationEntity,
             withCurrency givingCurrency: CurrencyEntity) throws -> WalletEntity {
        let neededBasedOnCurrencyAmmount: Double = ammount * buyingCurrency.buyPrice
        if !self.wallet.hasAtLeast(funds: neededBasedOnCurrencyAmmount,
                                     ofCurrencyAcronym: givingCurrency.acronym) {
            throw TransactionError.notEnoughFunds(ofCurrency: buyingCurrency.toAcronym)
        }

        try self.wallet.add(ammount: ammount, forCurrencyAcronym: buyingCurrency.toAcronym,
                            withName: buyingCurrency.currency.name)
        try self.wallet.subtract(ammount: neededBasedOnCurrencyAmmount,
                             ofCurrencyAcronym: buyingCurrency.toAcronym,
                             withName: buyingCurrency.currency.name)

        return self.wallet
    }

}
