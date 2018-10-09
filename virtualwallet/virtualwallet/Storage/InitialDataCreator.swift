//
//  InitialDataCreator.swift
//  virtualwallet
//
//  Created by victor-mac on 30/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct InitialDataCreator {
    static func createDefaultWallet(inContainer container: DataContainer) -> WalletEntity {
        let btcCurrency: CurrencyEntity = CurrencyEntity(context: container.walletDataContext)
        btcCurrency.acronym = "BTC"
        btcCurrency.name = "Bitcoin"
        btcCurrency.value = 0.0

        let usdCurrency: CurrencyEntity = CurrencyEntity(context: container.walletDataContext)
        usdCurrency.acronym = "USD"
        usdCurrency.name = "Dollar"
        usdCurrency.value = 100

        let brlCurrency: CurrencyEntity = CurrencyEntity(context: container.walletDataContext)
        brlCurrency.acronym = "BRL"
        brlCurrency.name = "Real"
        brlCurrency.value = 2000

        let wallet: WalletEntity = WalletEntity(context: container.walletDataContext)
        wallet.addToCurrencies(btcCurrency)
        wallet.addToCurrencies(usdCurrency)
        wallet.addToCurrencies(brlCurrency)

        return wallet
    }
}
