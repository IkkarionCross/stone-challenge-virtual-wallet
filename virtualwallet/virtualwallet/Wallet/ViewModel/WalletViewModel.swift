//
//  WalletViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 16/04/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct WalletViewModel {
    struct CurrencyViewModel: AccumulatableMoney {
        var name: String {
            return "\(currency.acronym ?? "") - \(currency.name ?? "")"
        }

        var amount: String {
            return "\(currency.acronym ?? "") \(currency.value)"
        }

        private var currency: CurrencyEntity
        init(currency: CurrencyEntity) {
            self.currency = currency
        }
    }

    private(set) var wallet: WalletEntity

    var currenciesCount: Int {
        return self.wallet.currencies?.count ?? 0
    }

    init(wallet: WalletEntity) {
        self.wallet = wallet
    }

    func currency(forIndexPath indexPath: IndexPath) -> CurrencyViewModel? {
        guard let startIndex = wallet.currencies?.startIndex else { return nil }
        guard let currencyIndex = wallet.currencies?.index(startIndex, offsetBy: indexPath.row) else { return nil }
        guard let currency: CurrencyEntity = wallet.currencies?[currencyIndex] else { return nil }
        return CurrencyViewModel(currency: currency)
    }
}
