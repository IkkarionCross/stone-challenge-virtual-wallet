//
//  WalletViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 16/04/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct WalletViewModel {
    private(set) var wallet: Wallet
    
    var currenciesCount: Int {
        return self.wallet.currencies.count
    }

    init(wallet: Wallet) {
        self.wallet = wallet
    }
    
    func currency(forIndexPath indexPath: IndexPath) -> (name: String, value: Double) {
        return (name: "", value: 0.0)
    }
}
