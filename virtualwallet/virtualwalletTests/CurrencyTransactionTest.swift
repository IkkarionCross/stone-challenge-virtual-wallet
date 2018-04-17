//
//  RealToBitcoinConversion.swift
//  virtualwalletTests
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import XCTest
@testable import virtualwallet

class CurrencyTransactionTest: XCTestCase {

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
        let currentCurrency = Wallet.CurrencyValue(name: bitcoinProperties.basedOnAcronym,
                                            value: 1000.0)
        let currentWallet: Wallet = Wallet(currencies: [currentCurrency])

        let transaction: CurrencyTransaction = CurrencyTransaction(withWallet: currentWallet)
        do {
            let newWallet: Wallet = try transaction.buy(ammount: 1.0, ofCurrency: bitcoinProperties)
            let expectedCurrency = Wallet.CurrencyValue(name: bitcoinProperties.acronym,
                                                        value: 1.0)
            let expectedWallet: Wallet = Wallet(currencies: [expectedCurrency])

            XCTAssertEqual(newWallet.currency(forAcronym: bitcoinProperties.acronym)?.value,
                           expectedWallet.currency(forAcronym: bitcoinProperties.acronym)?.value,
                           "Should have same ammount of \(bitcoinProperties.acronym)")
        } catch {
            XCTFail("Transaction failed with error: \(error.localizedDescription)")
        }
    }

    func test_ExchangeBitcoinForReal() {
        let realProperties: CurrencyProperties = CurrencyProperties(withAcronym: "BRL",
                                                                       sellPrice: 0.001, buyPrice: 0.001,
                                                                       basedOnAcronym: "BTC")
        let currenCurrency = Wallet.CurrencyValue(name: realProperties.basedOnAcronym,
                                                  value: 1.0)
        let currentWallet: Wallet = Wallet(currencies: [currenCurrency])

        let transaction: CurrencyTransaction = CurrencyTransaction(withWallet: currentWallet)
        do {
            let newWallet: Wallet = try transaction.buy(ammount: 1000.0, ofCurrency: realProperties)
            let expectedCurrency = Wallet.CurrencyValue(name: realProperties.acronym,
                                                        value: 1000.0)
            let expectedWallet: Wallet = Wallet(currencies: [expectedCurrency])

            XCTAssertEqual(newWallet.currency(forAcronym: realProperties.acronym)?.value,
                           expectedWallet.currency(forAcronym: realProperties.acronym)?.value,
                           "Should have same ammount of \(realProperties.acronym)")
        } catch {
            XCTFail("Transaction failed with error: \(error.localizedDescription)")
        }
    }

    func test_ShouldThrowExcepetion_notEnoughFunds() {
        let bitcoinProperties: CurrencyProperties = CurrencyProperties(withAcronym: "BTC",
                                                                       sellPrice: 1000.0, buyPrice: 1000.0,
                                                                       basedOnAcronym: "BRL")
        let currentWallet: Wallet = Wallet(currencies: [])

        let transaction: CurrencyTransaction = CurrencyTransaction(withWallet: currentWallet)
        do {
            let _: Wallet = try transaction.buy(ammount: 1.0, ofCurrency: bitcoinProperties)
            XCTFail("Should throw exception")
        } catch {
            XCTAssertEqual(error as? TransactionError,
                           TransactionError.notEnoughFunds(ofCurrency: bitcoinProperties.basedOnAcronym))
        }
    }
}
