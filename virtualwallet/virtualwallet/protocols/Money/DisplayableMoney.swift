//
//  DisplayableMoney.swift
//  virtualwallet
//
//  Created by victor-mac on 06/05/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol DisplayableMoney {
    var name: String {get}
}

protocol AccumulatableMoney: DisplayableMoney {
    var amount: String {get}
}

protocol OperableMoney: DisplayableMoney {
    var buy: String {get}
    var sell: String {get}
}
