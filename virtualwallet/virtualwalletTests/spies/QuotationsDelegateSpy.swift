//
//  QuotationsDelegateSpy.swift
//  virtualwalletTests
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import XCTest
@testable import virtualwallet

class QuotationsDelegateSpy: QuotationsDelegate {
    private(set) var onQuotationsUpdateCalled: Bool
    private(set) var receivedError: AppError?
    private var spyExpectation: XCTestExpectation

    init(WithSpyExpectation spyExpectation: XCTestExpectation) {
        self.onQuotationsUpdateCalled = false
        self.spyExpectation = spyExpectation
    }

    func onQuotationsUpdated(error: AppError?) {
        self.onQuotationsUpdateCalled = true
        self.receivedError = error
        self.spyExpectation.fulfill()
    }
}
