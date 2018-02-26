//
//  JSONTicker.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
enum JSONTickerKey: String {
    case ticker
}
struct JSONTicker: Decodable {
    let high: Double
    let low: Double
    let vol: Double
    let last: Double
    let buy: Double
    let cell: Double
    let date: Date
}
