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
    let name: String
    let sellPrice: Double
    let buyPrice: Double
    let basedOnAcronym: String
    let basedOnName: String
    init(withAcronym acronym: String, name: String, sellPrice: Double,
         buyPrice: Double, basedOnAcronym: String, basedOnName: String) {
        self.acronym = acronym
        self.name = name
        self.sellPrice = sellPrice
        self.buyPrice = buyPrice
        self.basedOnAcronym = basedOnAcronym
        self.basedOnName = basedOnName
    }
}
