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

    var useInvertedQuotation: Bool = false

    init(withWallet wallet: WalletEntity) {
        self.wallet = wallet
    }

    func convert(amount: Double,
                 quotation: QuotationEntity) -> Double {
        if useInvertedQuotation {
            return (amount * quotation.invertedBuyPrice)
        } else {
            return (amount * quotation.buyPrice)
        }
    }

    func buy(ammount: Double, withQuotation quotation: QuotationEntity,
             ofCurrency buyingCurrency: CurrencyEntity,
             withExchangeCurrency exchangeCurrency: CurrencyEntity) throws -> WalletEntity {
        let neededBasedOnCurrencyAmmount: Double =
            convert(amount: ammount, quotation: quotation)
        if !self.wallet.hasAtLeast(funds: neededBasedOnCurrencyAmmount,
                                     ofCurrencyAcronym: buyingCurrency.acronym) {
            throw TransactionError.notEnoughFunds(ofCurrency: buyingCurrency.acronym)
        }

        try self.wallet.add(ammount: ammount, forCurrencyAcronym: exchangeCurrency.acronym,
                            withName: exchangeCurrency.name)
        try self.wallet.subtract(ammount: neededBasedOnCurrencyAmmount,
                             ofCurrencyAcronym: buyingCurrency.acronym,
                             withName: buyingCurrency.name)

        return self.wallet
    }
}
