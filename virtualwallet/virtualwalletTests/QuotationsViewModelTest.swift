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

    override func setUp() {
        super.setUp()
        quotationsViewModel = QuotationsViewModel(quotations: [])
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
}
