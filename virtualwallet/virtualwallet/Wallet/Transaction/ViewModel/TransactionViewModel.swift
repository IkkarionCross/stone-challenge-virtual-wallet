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

    private var exchangeValue: Double {
        return exchangeAmount
            .currencyStringToDouble(currencySymbol: self.exchangeForCurrency)
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

    func doTransaction() throws {
        let quotation = try transactionQuotation()
        guard let fromCurrency: CurrencyEntity = wallet.currency(forAcronym: buyCurrency) else {
            throw TransactionError.unrecognizedCurrency
        }
        guard let toCurrency: CurrencyEntity = wallet.currency(forAcronym: exchangeForCurrency) else {
            throw TransactionError.unrecognizedCurrency
        }
        transaction.useInvertedQuotation = quotation.useInverted
        wallet = try transaction.buy(ammount: exchangeValue, withQuotation: quotation.quotation,
                        ofCurrency: fromCurrency,
                        withExchangeCurrency: toCurrency)

        _ = try transactionEntity(withQuotation: quotation.quotation)
        try dataContainer?.walletDataContext.save()
    }

    func totalValue() throws -> String {
        let quotation = try transactionQuotation()

        return self.calculateTotalValue(forExchangeAmount: exchangeValue,
                                        quotation: quotation.quotation,
                                        useInverted: quotation.useInverted)
    }

    private func transactionQuotation() throws -> (quotation: QuotationEntity, useInverted: Bool) {
        var useInverted: Bool = true
        var lastQuotation: QuotationEntity? =
            try service?.lastQuotation(fromCurrency: self.buyCurrency, toCurrency: self.exchangeForCurrency)
        if lastQuotation == nil {
            useInverted = false
            lastQuotation =
                try service?.lastQuotation(fromCurrency: self.exchangeForCurrency, toCurrency: self.buyCurrency)
        }

        guard let quotation: QuotationEntity = lastQuotation else {
            throw TransactionError.noQuotations
        }

        return (quotation: quotation, useInverted: useInverted)
    }

    private func transactionEntity(withQuotation quotation: QuotationEntity) throws -> TransactionEntity {
        guard let context = dataContainer?.walletDataContext else {
            throw CoreDataError.invalidContext
        }
        let transactionEntity: TransactionEntity = TransactionEntity(context: context)
        transactionEntity.fromCurrencyAcronym = exchangeForCurrency
        transactionEntity.toCurrencyAcronym = buyCurrency
        transactionEntity.value = exchangeValue
        transactionEntity.quotationUsed = quotation
        transactionEntity.wallet = wallet

        return transactionEntity
    }

    private func calculateTotalValue(forExchangeAmount amount: Double,
                                     quotation: QuotationEntity,
                                     useInverted: Bool) -> String {
        transaction.useInvertedQuotation = useInverted
        let total: Double = self.transaction.convert(amount: amount,
                                                     quotation: quotation)
        guard let formattedTotal: String = total.currencyString(withSymbol: self.buyCurrency) else {
            return ""
        }
        return formattedTotal
    }
}

extension TransactionViewModel: Persistable {}
