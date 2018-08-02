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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        guard let highValue = try
            Double(container.decode(String.self, forKey: .high)) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [CodingKeys.high],
                    debugDescription: "Expecting string representation of Double"))
        }
        guard let lowValue = try
            Double(container.decode(String.self, forKey: .low)) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [CodingKeys.low],
                    debugDescription: "Expecting string representation of Double"))
        }
        guard let volValue = try
            Double(container.decode(String.self, forKey: .vol)) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [CodingKeys.vol],
                    debugDescription: "Expecting string representation of Double"))
        }
        guard let lastValue = try
            Double(container.decode(String.self, forKey: .last)) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [CodingKeys.last],
                    debugDescription: "Expecting string representation of Double"))
        }
        guard let buyValue = try
            Double(container.decode(String.self, forKey: .buy)) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [CodingKeys.buy],
                    debugDescription: "Expecting string representation of Double"))
        }
        guard let sellValue = try
            Double(container.decode(String.self, forKey: .sell)) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [CodingKeys.sell],
                    debugDescription: "Expecting string representation of Double"))
        }

        self.high = highValue
        self.low = lowValue
        self.vol = volValue
        self.last = lastValue
        self.buy = buyValue
        self.sell = sellValue
    }

    static func decodeDateStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .millisecondsSince1970
    }

    static func encodeDateStrategy() -> JSONEncoder.DateEncodingStrategy {
        return .millisecondsSince1970
    }
}
