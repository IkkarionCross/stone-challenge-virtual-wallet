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

    var exchangeForCurrency: String {
        didSet {
            self.exchangeCurrencySelectedIndex = acceptedCurrencies.index(of: exchangeForCurrency) ?? 0
        }
    }
    var buyCurrency: String {
        didSet {
            self.buyCurrencySelectedIndex = acceptedCurrencies.index(of: buyCurrency) ?? 0
        }
    }

    private(set) var exchangeCurrencySelectedIndex: Int

    private(set) var buyCurrencySelectedIndex: Int

    private let acceptedCurrencies: [String] = ["BTC", "USD", "BRL", "BRITAS"]

    init() {
        self.exchangeForCurrency = acceptedCurrencies[0]
        self.buyCurrency = acceptedCurrencies[1]
        self.exchangeCurrencySelectedIndex = 0
        self.buyCurrencySelectedIndex = 1
    }

    func acceptedCurrency(forRow row: Int) -> String? {
        if row >= acceptedCurrenciesCount {
            return nil
        }
        return acceptedCurrencies[row]
    }
}
