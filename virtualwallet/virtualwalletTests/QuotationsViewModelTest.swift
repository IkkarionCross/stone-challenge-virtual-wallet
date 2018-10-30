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
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
