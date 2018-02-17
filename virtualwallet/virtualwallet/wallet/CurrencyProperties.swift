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
    let basedOnAcronym: String
    init(withAcronym acronym: String, sellPrice: Double, buyPrice: Double, basedOnAcronym: String) {
        self.acronym = acronym
        self.sellPrice = sellPrice
        self.buyPrice = buyPrice
        self.basedOnAcronym = basedOnAcronym
    }
}
