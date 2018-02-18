//
//  UpdateCurrencyTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 18/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import virtualwallet

class UpdateCurrencyTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_ShouldReturnJSON() throws {
        let updateExpectation = expectation(description: "Update Currency")
        let urlCurrencyParam: String = "USD"
        let urlDateParam: Date = Date()
        let urlFormattedDateParam: String = Date().formattedWith(format: "MM-dd-yyyy")
        let request: CurrencyRouter =
            CurrencyRouter.retrieveQuotationFor(currencyAcronym: urlCurrencyParam, date: urlDateParam)

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [:],
                                       statusCode: 200,
                                       headers: ["content-type": "application/json"])
        }
        var expectedURLString: String =
            "\(BaseRouter.baseBCDURL)/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)"
        expectedURLString.append("?%24format=json&%40dataCotacao=%27\(urlFormattedDateParam)%27")
        expectedURLString.append("&%40moeda=%27\(urlCurrencyParam)%27")

        XCTAssertEqual(try request.asURLRequest().url?.absoluteString, expectedURLString)

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCurrencyPropertiesOperation = UpdateCurrencyPropertiesOperation(service: service)

        operation.operationDidFinish = { error, info in
            updateExpectation.fulfill()
            XCTAssertNil(error)
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }

    func test_ShouldReturnError_HTTP500() {
        let updateExpectation = expectation(description: "Update Currency")
        let expectedError = NetworkError.serverError(statusCode: "500",
                                                     message: "Response status code was unacceptable: 500.")
        let urlCurrencyParam: String = "USD"
        let urlDateParam: Date = Date()
        let request: CurrencyRouter =
            CurrencyRouter.retrieveQuotationFor(currencyAcronym: urlCurrencyParam, date: urlDateParam)

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [:], statusCode: 500, headers: ["content-type": "application/json"])
        }

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCurrencyPropertiesOperation = UpdateCurrencyPropertiesOperation(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertEqual(error as? NetworkError, expectedError)
            updateExpectation.fulfill()
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }
}
