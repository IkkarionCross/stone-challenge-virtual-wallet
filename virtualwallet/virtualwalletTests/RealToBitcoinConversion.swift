//
//  RealToBitcoinConversion.swift
//  virtualwalletTests
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
@testable import virtualwallet

class RealToBitcoinConversion: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_BuyBitcoin() {
        let bitcoinProperties: CurrencyProperties = CurrencyProperties(withAcronym: "BTC",
                                                                       sellPrice: 1000.0, buyPrice: 1000.0,
                                                                       basedOnAcronym: "BRL")
        let currentWallet: Wallet = Wallet(currencies: [bitcoinProperties.basedOnAcronym: 1000.0])

        let transaction: CurrencyTransaction = CurrencyTransaction(withWallet: currentWallet)
        do {
            let newWallet: Wallet = try transaction.buy(ammount: 1.0, ofCurrency: bitcoinProperties)
            let expectedWallet: Wallet = Wallet(currencies: [bitcoinProperties.acronym: 1.0])

            XCTAssertEqual(newWallet.currencies[bitcoinProperties.acronym],
                           expectedWallet.currencies[bitcoinProperties.acronym],
                           "Should have same ammount of \(bitcoinProperties.acronym)")
        } catch {
            XCTFail("Transaction failed with error: \(error.localizedDescription)")
        }
    }

    func test_ExchangeBitcoinForReal() {
        let realProperties: CurrencyProperties = CurrencyProperties(withAcronym: "BRL",
                                                                       sellPrice: 0.001, buyPrice: 0.001,
                                                                       basedOnAcronym: "BTC")
        let currentWallet: Wallet = Wallet(currencies: [realProperties.basedOnAcronym: 1.0])

        let transaction: CurrencyTransaction = CurrencyTransaction(withWallet: currentWallet)
        do {
            let newWallet: Wallet = try transaction.buy(ammount: 1000.0, ofCurrency: realProperties)
            let expectedWallet: Wallet = Wallet(currencies: [realProperties.acronym: 1000.0])

            XCTAssertEqual(newWallet.currencies[realProperties.acronym],
                           expectedWallet.currencies[realProperties.acronym],
                           "Should have same ammount of \(realProperties.acronym)")
        } catch {
            XCTFail("Transaction failed with error: \(error.localizedDescription)")
        }
    }
}
