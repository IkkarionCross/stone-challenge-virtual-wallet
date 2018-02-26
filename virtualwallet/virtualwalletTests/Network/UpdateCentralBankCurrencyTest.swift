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

class UpdateCentralBankCurrencyTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func test_ShouldReturnJSON() throws {
        let updateExpectation = expectation(description: "Update Currency")
        let urlCurrencyParam: String = "USD"
        let request: CentralBankRouter =
            CentralBankRouter.recentQuotationFor(currencyAcronym: urlCurrencyParam)
        let urlFormattedDateParam: String = request.recentQuotationDate().formattedWith(format: "MM-dd-yyyy")

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [QuotationListKey.value.rawValue: []],
                                       statusCode: 200,
                                       headers: ["content-type": "application/json"])
        }
        var expectedURLString: String =
            "\(BaseRouter.baseBCDURL)/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)"
        expectedURLString.append("?%24format=json&%40dataCotacao=%27\(urlFormattedDateParam)%27")
        expectedURLString.append("&%40moeda=%27\(urlCurrencyParam)%27")

        XCTAssertEqual(try request.asURLRequest().url?.absoluteString, expectedURLString)

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCentralBankCurrency = UpdateCentralBankCurrency(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertNil(error)
            updateExpectation.fulfill()
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }

    func test_ShouldReturnError_ServerError() {
        let updateExpectation = expectation(description: "Update Currency")
        let expectedError = NetworkError.serverError(statusCode: "500",
                                                     message: "Response status code was unacceptable: 500.")
        let urlCurrencyParam: String = "USD"
        let request: CentralBankRouter =
            CentralBankRouter.recentQuotationFor(currencyAcronym: urlCurrencyParam)

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [:], statusCode: 500, headers: ["content-type": "application/json"])
        }

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCentralBankCurrency = UpdateCentralBankCurrency(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertEqual(error as? NetworkError, expectedError)
            updateExpectation.fulfill()
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }

    func test_ShouldReturnError_invalidDataReceived() {
        let updateExpectation = expectation(description: "Update Currency")

        let urlCurrencyParam: String = "USD"
        let request: CentralBankRouter =
            CentralBankRouter.recentQuotationFor(currencyAcronym: urlCurrencyParam)

        let expectedError = NetworkError.invalidDataReceived(requestDescription: request.requestDescription)

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            if let data = "[null]".data(using: String.Encoding.utf8) {
                return OHHTTPStubsResponse(data: data, statusCode: 200, headers: ["content-type": "application/json"])
            }
            return OHHTTPStubsResponse()
        }

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCentralBankCurrency = UpdateCentralBankCurrency(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertEqual(error as? NetworkError, expectedError)
            updateExpectation.fulfill()
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }

    func test_TryParseJSONWithError_parseError() {
        let updateExpectation = expectation(description: "Update Currency")

        let urlCurrencyParam: String = "USD"
        let request: CentralBankRouter =
            CentralBankRouter.recentQuotationFor(currencyAcronym: urlCurrencyParam)

        let expectedError = JSONError.parseError

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            if let data = "{\"value\":[{\"test\":[null]}]}".data(using: String.Encoding.utf8) {
                return OHHTTPStubsResponse(data: data, statusCode: 200, headers: ["content-type": "application/json"])
            }
            return OHHTTPStubsResponse()
        }

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCentralBankCurrency = UpdateCentralBankCurrency(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertEqual(error as? JSONError, expectedError)
            updateExpectation.fulfill()
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }

    func test_ShouldNotParseJSONInvalidMainKey_invalidDataReceived() {
        let updateExpectation = expectation(description: "Update Currency")

        let urlCurrencyParam: String = "USD"
        let request: CentralBankRouter =
            CentralBankRouter.recentQuotationFor(currencyAcronym: urlCurrencyParam)

        let expectedError = NetworkError.invalidDataReceived(requestDescription: request.requestDescription)

        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            if let data = "{\"value\":[null]}".data(using: String.Encoding.utf8) {
                return OHHTTPStubsResponse(data: data, statusCode: 200, headers: ["content-type": "application/json"])
            }
            return OHHTTPStubsResponse()
        }

        let service: RESTService = RESTService(request: request, queue: DispatchQueue.global())
        let operation: UpdateCentralBankCurrency = UpdateCentralBankCurrency(service: service)

        operation.operationDidFinish = { error, info in
            XCTAssertEqual(error as? NetworkError, expectedError)
            updateExpectation.fulfill()
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }
}