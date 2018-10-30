//
//  SupportedCurrencies.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum SupportedCurrencies: String {
    case USD,
         BTC,
         BRITAS,
         BRL
}

enum CurrencyProvider: Int {
    case centralBank,
         bitcoinMarket
}
