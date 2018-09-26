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

class TransactionViewModel: NSObject {
    var service: QuotationServant?

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
        didSet {
//            let value: Double = exchangeAmount.currencyStringToDouble(currencySymbol: self.exchangeForCurrency)
//            if !service.hasQuotations(inContext: wallet.managedObjectContext, forCurrency: self.exchangeForCurrency, inWallet: self.wallet) {
//                    service.fetchQuotations(fromCurrencyProvider: .centralBank) { [weak self] result in
//                        switch result {
//                        case .success:
//                            self?.calculateTotalValue(forExchangeAmount: value, withQuotation: quotation)
//                        case let .failure(error):
//                            ()
//                        }
//
//                }
//            } else {
//                if let quotation: QuotationEntity = self.wallet.currencies?.filter({ $0.acronym == self.exchangeForCurrency}).first {
//                    self.calculateTotalValue(forExchangeAmount: value, withQuotation: quotation)
//                }
//            }
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

    private(set) var totalValue: String

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
        self.totalValue = "0.00"
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

    private func calculateTotalValue(forExchangeAmount amount: Double, withQuotation quotation: QuotationEntity) {
        let total: Double = self.transaction.convert(amount: amount, toQuotation: quotation)
        self.totalValue = "\(self.buyCurrency)\(total)"
    }
}

extension TransactionViewModel: Persistable {}
