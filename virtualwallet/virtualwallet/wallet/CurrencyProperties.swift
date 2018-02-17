//
//  CurrencyProperties.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

struct CurrencyProperties {
    let acronym: String
    let sellPrice: Double
    let buyPrice: Double
    let basedOnCurrencyAcronym: String
    init(withAcronym acronym: String, sellPrice: Double, buyPrice: Double, basedOnCurrencyAcronym: String) {
        self.acronym = acronym
        self.sellPrice = sellPrice
        self.buyPrice = buyPrice
        self.basedOnCurrencyAcronym = basedOnCurrencyAcronym
    }
}
