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

    func test_ShouldNotReturnJSON_ServerError() {
        let updateExpectation = expectation(description: "update digital currency")
        let expectedError = NetworkError.serverError(statusCode: "500",
                                                     message: "Response status code was unacceptable: 500.")
        stub(condition: isHost(BaseRouter.bitcoinMarketHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [:], statusCode: 500, headers: ["content-type": "application/json"])
        }
        let bitcoinRequest: BitcoinMarketRouter = BitcoinMarketRouter.recentQuotationFor(currency:
            SupportedCurrencies.BTC.rawValue)
        let service: RESTService = RESTService(request: bitcoinRequest, queue: DispatchQueue.global())

        let operation: UpdateDigitalCurrencyOperation = UpdateDigitalCurrencyOperation(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
            updateExpectation.fulfill()
        }

        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }

    func test_ShouldReturnJSON() {
        let updateExpectation = expectation(description: "update digital currency")

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [JSONTickerKey.ticker.rawValue: [:]],
                                       statusCode: 200,
                                       headers: ["content-type": "application/json"])
        }
        let bitcoinRequest: BitcoinMarketRouter = BitcoinMarketRouter.recentQuotationFor(currency:
            SupportedCurrencies.BTC.rawValue)
        let service: RESTService = RESTService(request: bitcoinRequest, queue: DispatchQueue.global())

        let operation: UpdateDigitalCurrencyOperation = UpdateDigitalCurrencyOperation(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertNil(error)
            updateExpectation.fulfill()
        }

        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }
}
