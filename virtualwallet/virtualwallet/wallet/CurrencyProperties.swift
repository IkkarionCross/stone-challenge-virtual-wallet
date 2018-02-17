//
//  CurrencyProperties.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
// TODO: Maybe change this name to something like "CapitalProperties" to make it more generic.
// I think that currency seems to apply only to coins (virtual or not)
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
