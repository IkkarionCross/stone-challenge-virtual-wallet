//
//  TransactionViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 22/05/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
protocol TransactionDelegate: class {
    func didExchangeCurrencyTypeChanged()
    func didBuyCurrencyTypeChanged()
    func didTransactionTypeChanged()
}

class TransactionViewModel {

    var acceptedCurrenciesCount: Int {
        return acceptedCurrencies.count
    }

    var exchangeForCurrency: String {
        didSet {
            if oldValue != exchangeForCurrency {
                self.exchangeCurrencySelectedIndex = acceptedCurrencies.index(of: exchangeForCurrency) ?? 0
                self.delegate?.didExchangeCurrencyTypeChanged()
            }
        }
    }
    var buyCurrency: String {
        didSet {
            if oldValue != buyCurrency {
                self.buyCurrencySelectedIndex = acceptedCurrencies.index(of: buyCurrency) ?? 0
                self.delegate?.didBuyCurrencyTypeChanged()
            }
        }
    }

    var exchangeAmount: String {
        get {
            return "\(self.exchangeForCurrency)0.00"
        }
        set {
            
        }
    }

    var transactionType: TransactionType {
        didSet {
            self.delegate?.didTransactionTypeChanged()
        }
    }

    var buyCurrencyDescription: String {
        return "\(transactionType.description) com"
    }
    
    var totalValue: String {
        return "\(self.buyCurrency)0.00"
    }

    private(set) var exchangeCurrencySelectedIndex: Int

    private(set) var buyCurrencySelectedIndex: Int

    private let acceptedCurrencies: [String] = ["BTC", "USD", "BRL", "BRITAS"]
    weak var delegate: TransactionDelegate?

    init() {
        self.exchangeForCurrency = acceptedCurrencies[0]
        self.buyCurrency = acceptedCurrencies[1]
        self.exchangeCurrencySelectedIndex = 0
        self.buyCurrencySelectedIndex = 1
        self.transactionType = TransactionType.buy
    }

    func acceptedCurrency(forRow row: Int) -> String? {
        if row >= acceptedCurrenciesCount {
            return nil
        }
        return acceptedCurrencies[row]
    }
}
