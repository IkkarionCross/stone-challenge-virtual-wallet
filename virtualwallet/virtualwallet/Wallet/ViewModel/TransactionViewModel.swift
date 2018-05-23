//
//  TransactionViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 22/05/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct TransactionViewModel {
    var acceptedCurrenciesCount: Int {
        return acceptedCurrencies.count
    }

    var exchangeForCurrency: String
    var buyCurrency: String

    var exchangeCurrencySelectedIndex: Int {
        return acceptedCurrencies.index(of: exchangeForCurrency) ?? 0
    }

    var buyCurrencySelectedIndex: Int {
        return acceptedCurrencies.index(of: buyCurrency) ?? 0
    }

    private let acceptedCurrencies: [String] = ["BTC", "USD", "BRL", "BRITAS"]

    init() {
        self.exchangeForCurrency = ""
        self.buyCurrency = ""
    }

    func acceptedCurrency(forRow row: Int) -> String? {
        if row >= acceptedCurrenciesCount {
            return nil
        }
        return acceptedCurrencies[row]
    }
}
