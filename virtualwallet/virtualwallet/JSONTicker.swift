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
struct JSONTicker: Decodable, DateDecodable {
    let high: Double
    let low: Double
    let vol: Double
    let last: Double
    let buy: Double
    let sell: Double
    let date: Date

    enum CodingKeys: String, CodingKey {
        case high
        case low
        case vol
        case last
        case buy
        case sell
        case date
    }

    static func decodeDateStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .millisecondsSince1970
    }
    
    static func encodeDateStrategy() -> JSONEncoder.DateEncodingStrategy {
        return .millisecondsSince1970
    }
}
