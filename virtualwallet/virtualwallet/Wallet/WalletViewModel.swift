//
//  WalletViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 16/04/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct WalletViewModel {
    struct CurrencyViewModel {
        var name: String {
            return "\(currency.acronym) - \(currency.name)"
        }

        var value: String {
            return "\(currency.acronym) \(currency.value)"
        }

        private var currency: Wallet.CurrencyValue
        init(currency: Wallet.CurrencyValue) {
            self.currency = currency
        }
    }
    
    private(set) var wallet: Wallet

    var currenciesCount: Int {
        return self.wallet.currencies.count
    }

    init(wallet: Wallet) {
        self.wallet = wallet
    }

    func currency(forIndexPath indexPath: IndexPath) -> CurrencyViewModel? {
        guard let currency: Wallet.CurrencyValue = wallet.currency(forIndex: indexPath.row) else {
            return nil
        }
        return CurrencyViewModel(currency: currency)
    }
}
