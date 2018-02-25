//
//  DateAdditionsTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
@testable import virtualwallet

class DateAdditionsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ShouldReturnLastFriday() {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let lastFridayString: String = "2018-02-23"
        guard let expectedDate: Date = formatter.date(from: lastFridayString) else {
            return XCTFail("Date is nil")
        }

        let aDateString: String = "2018-02-28" //thuesday

        guard let aDate: Date = formatter.date(from: aDateString) else {
            return XCTFail("Date is nil")
        }
        guard let lastFriday: Date = aDate.lastFriday() else {
            return XCTFail("Date is nil")
        }
        XCTAssertEqual(lastFriday, expectedDate)
    }
}
