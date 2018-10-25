//
//  TransactionViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 22/05/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
protocol TransactionDelegate: class {
    func didBuyCurrencyTypeChanged()
    func didTransactionTypeChanged()
    func didExchangeAmountChanged()
}

class TransactionViewModel: NSObject {
    var service: QuotationServant?

    var acceptedCurrenciesCount: Int {
        return acceptedCurrencies.count
    }

    var exchangeForCurrency: String {
        didSet {
            if oldValue != exchangeForCurrency {
                self.exchangeCurrencySelectedIndex = acceptedCurrencies.index(of: exchangeForCurrency) ?? 0
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
        didSet {
            delegate?.didExchangeAmountChanged()
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

    private(set) var exchangeCurrencySelectedIndex: Int

    private(set) var buyCurrencySelectedIndex: Int

    private let acceptedCurrencies: [String] = ["BTC", "USD", "BRL", "BRITAS"]
    weak var delegate: TransactionDelegate?

    private var transaction: CurrencyTransaction

    private var wallet: WalletEntity

    var dataContainer: DataContainer?

    init(saveTransactionsInWallet wallet: WalletEntity, dataContainer: DataContainer) {
        self.dataContainer = dataContainer
        self.service = QuotationsService(dataContainer: dataContainer)
        self.wallet = wallet
        self.exchangeAmount = "0.00"
        self.exchangeForCurrency = acceptedCurrencies[0]
        self.buyCurrency = acceptedCurrencies[1]
        self.exchangeCurrencySelectedIndex = 0
        self.buyCurrencySelectedIndex = 1
        self.transactionType = TransactionType.buy

        self.transaction = CurrencyTransaction(withWallet: wallet)
    }

    func acceptedCurrency(forRow row: Int) -> String? {
        if row >= acceptedCurrenciesCount {
            return nil
        }
        return acceptedCurrencies[row]
    }

    func totalValue() throws -> String {
        let value: Double = exchangeAmount.currencyStringToDouble(currencySymbol: self.exchangeForCurrency)
        guard let toQuotation: QuotationEntity =
            try service?.lastQuotation(forCurrency: self.exchangeForCurrency) else {
            throw TransactionError.noQuotations
        }
        guard let fromQuotation: QuotationEntity = try service?.lastQuotation(forCurrency: self.buyCurrency) else {
            throw TransactionError.noQuotations
        }
        return self.calculateTotalValue(forExchangeAmount: value,
                                        toQuotation: toQuotation, fromQuotation: fromQuotation)
    }

    private func calculateTotalValue(forExchangeAmount amount: Double,
                                     toQuotation: QuotationEntity,
                                     fromQuotation: QuotationEntity) -> String {
        let total: Double = self.transaction.convert(amount: amount,
                                                     toQuotation: toQuotation,
                                                     fromQuotation: fromQuotation)
        guard let formattedTotal: String = total.currencyString(withSymbol: self.buyCurrency) else {
            return ""
        }
        return formattedTotal
    }
}

extension TransactionViewModel: Persistable {}
