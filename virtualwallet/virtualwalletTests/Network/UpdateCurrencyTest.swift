//
//  UpdateCurrencyTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 18/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
@testable import virtualwallet

class UpdateCurrencyTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ShouldReturnJSON() {
        let updateExpectation = expectation(description: "Update Currency")

        let path: CurrencyRouter = CurrencyRouter.retrieveQuotationFor(currencyAcronym: "USD", date: Date())
        let service: RESTService<[String: Any]> = RESTService<[String: Any]>(request: path,
                                                                             queue: DispatchQueue.global())
        let operation: UpdateCurrencyPropertiesOperation = UpdateCurrencyPropertiesOperation(service: service)

        operation.operationDidFinish = { error, info in
            updateExpectation.fulfill()
            XCTAssertNil(error)
        }
        let queue: OperationQueue = OperationQueue()
        queue.addOperation(operation)

        wait(for: [updateExpectation], timeout: 5.0)
    }
}
