//
//  MainViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 06/05/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct MainViewModel {
    enum Section: Int {
        case wallet = 0, quotations = 1
    }

    private var walletViewModel: WalletViewModel

    init() {
        let wallet: Wallet = Wallet(currencies: [Wallet.CurrencyValue(acronym: "BTC", value: 0.0, name: "Bitcoin"),
                                                 Wallet.CurrencyValue(acronym: "USD", value: 100.0, name: "Dólar"),
                                                 Wallet.CurrencyValue(acronym: "BRL", value: 2000.0, name: "Real")])

        walletViewModel = WalletViewModel(wallet: wallet)
    }

    func rows(forSection section: Int) -> Int {
        switch section {
        case Section.wallet.rawValue:
            return self.walletViewModel.currenciesCount
        case Section.quotations.rawValue:
            return 0
        default:
            return 0
        }
    }

    func money(forIndexPath indexPath: IndexPath) -> DisplayableMoney? {
        switch indexPath.section {
        case Section.wallet.rawValue:
            return self.walletViewModel.currency(forIndexPath: indexPath)
        case Section.quotations.rawValue:
            return nil
        default:
            return nil
        }

    }
}
