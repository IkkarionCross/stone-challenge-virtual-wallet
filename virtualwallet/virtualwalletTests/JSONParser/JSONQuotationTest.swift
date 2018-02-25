//
//  JSONQuotationTest.swift
//  virtualwalletTests
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
@testable import virtualwallet

class JSONQuotationTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ShouldParseQuotation() throws {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        let quotation1: [String: Any] = [JSONQuotation.CodingKeys.timeStamp.rawValue: "2018-02-23 14:08:49.444",
                                            JSONQuotation.CodingKeys.buyParity.rawValue: 1.0,
                                            JSONQuotation.CodingKeys.sellParity.rawValue: 1.0,
                                            JSONQuotation.CodingKeys.sellQuotation.rawValue: 2.0,
                                            JSONQuotation.CodingKeys.buyQuotation.rawValue: 2.0,
                                            JSONQuotation.CodingKeys.reportType.rawValue:
                                                QuotationReportType.close.rawValue]

        let quotation2: [String: Any] = [JSONQuotation.CodingKeys.timeStamp.rawValue: "2018-02-23 10:11:45.444",
                                         JSONQuotation.CodingKeys.buyParity.rawValue: 1.0,
                                         JSONQuotation.CodingKeys.sellParity.rawValue: 1.0,
                                         JSONQuotation.CodingKeys.sellQuotation.rawValue: 2.0,
                                         JSONQuotation.CodingKeys.buyQuotation.rawValue: 2.0,
                                         JSONQuotation.CodingKeys.reportType.rawValue:
                                            QuotationReportType.close.rawValue]

        let jsonData = try JSONSerialization.data(withJSONObject: [quotation1, quotation2], options: [])

        let quotations: [JSONQuotation] = try decoder.decode([JSONQuotation].self, from: jsonData)

        XCTAssertTrue(quotations.count == 2)
    }
}
