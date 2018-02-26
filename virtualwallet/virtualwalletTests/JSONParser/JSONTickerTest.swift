//
//  JSONTickerTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
@testable import virtualwallet

class JSONTickerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ShouldParseJSON() throws {
        let tickerJSON: [String: Any] = [JSONTicker.CodingKeys.buy.rawValue: 2.0,
                                         JSONTicker.CodingKeys.sell.rawValue: 2.0,
                                         JSONTicker.CodingKeys.low.rawValue: 2.0,
                                         JSONTicker.CodingKeys.high.rawValue: 2.0,
                                         JSONTicker.CodingKeys.vol.rawValue: 2.0,
                                         JSONTicker.CodingKeys.last.rawValue: 2.0,
                                         JSONTicker.CodingKeys.date.rawValue: 1502977646]

        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONTicker.decodeDateStrategy()

        let tickerData: Data = try JSONSerialization.data(withJSONObject: tickerJSON,
                                                          options: [])

        let ticker: JSONTicker = try decoder.decode(JSONTicker.self, from: tickerData)

        XCTAssertNotNil(ticker)
    }

}
