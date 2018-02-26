//
//  UpdateDigitalCurrencyOperationTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import virtualwallet

class UpdateDigitalCurrencyOperationTest: XCTestCase {

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func test_ShouldReturnJSON() {
        let bitcoinRequest: BitcoinMarketRouter = BitcoinMarketRouter.recentQuotationFor(currency:
            SupportedCurrencies.BTC.rawValue)
        let service: RESTService = RESTService(request: bitcoinRequest, queue: DispatchQueue.global())
        
        let updateDigitalCurrency: UpdateDigitalCurrencyOperation = UpdateDigitalCurrencyOperation(service: service)
    }
}
