//
//  QuotationsViewModelTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import virtualwallet

class QuotationsViewModelTest: XCTestCase {
    var quotationsViewModel: QuotationsViewModel!
    var expectedQuotation: JSONQuotation!

    override func setUp() {
        super.setUp()
        expectedQuotation = JSONQuotation(buyParity: 2.0,
                                    sellParity: 2.0,
                                    buyQuotation: 2.0,
                                    sellQuotation: 2.0,
                                    timeStamp: Date(),
                                    reportType: QuotationReportType.intermediary)
        quotationsViewModel = QuotationsViewModel(quotations: [expectedQuotation])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ShouldUpdateQuotations() {
        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [QuotationListKey.value.rawValue: []],
                                       statusCode: 200,
                                       headers: ["content-type": "application/json"])
        }

        let quotationExpectation = expectation(description: "quotations")

        let quotationsSpy: QuotationsDelegateSpy = QuotationsDelegateSpy(WithSpyExpectation: quotationExpectation)
        self.quotationsViewModel.delegate = quotationsSpy
        self.quotationsViewModel.updateQuotationsFromNetwork()

        waitForExpectations(timeout: 5000) { _ in
            XCTAssertTrue(quotationsSpy.onQuotationsUpdateCalled)
            XCTAssertNil(quotationsSpy.receivedError)
        }
    }

    func test_ShouldNotUpdateQuotations_ServerError() {
        let expectedError = NetworkError.serverError(statusCode: "500",
                                                     message: "Response status code was unacceptable: 500.")
        stub(condition: isHost(BaseRouter.baseBCDHost)) { _ in
            return OHHTTPStubsResponse(jsonObject: [:], statusCode: 500, headers: ["content-type": "application/json"])
        }

        let quotationExpectation = expectation(description: "quotations")

        let quotationsSpy: QuotationsDelegateSpy = QuotationsDelegateSpy(WithSpyExpectation: quotationExpectation)
        self.quotationsViewModel.delegate = quotationsSpy
        self.quotationsViewModel.updateQuotationsFromNetwork()

        waitForExpectations(timeout: 5000) { _ in
            XCTAssertTrue(quotationsSpy.onQuotationsUpdateCalled)
            XCTAssertEqual(quotationsSpy.receivedError?.localizedDescription, expectedError.localizedDescription)
        }
    }

    func test_ShouldReturnAllQuotations() {
        let expectedCount = 1
        XCTAssertEqual(quotationsViewModel.allQuotations().count, expectedCount)
    }

    func test_ShouldReturnQuotationForIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let quotation: JSONQuotation = quotationsViewModel.quotation(at: indexPath)
        XCTAssertEqual(quotation.buyParity, expectedQuotation.buyParity)
        XCTAssertEqual(quotation.buyQuotation, expectedQuotation.buyQuotation)
        XCTAssertEqual(quotation.timeStamp, expectedQuotation.timeStamp)
        XCTAssertEqual(quotation.sellParity, expectedQuotation.sellParity)
        XCTAssertEqual(quotation.sellQuotation, expectedQuotation.sellQuotation)
    }
}
