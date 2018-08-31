//
//  WalletEntity+CoreDataClass.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WalletEntity)
public class WalletEntity: NSManagedObject {

    static func currentWallet(fromContext context: NSManagedObjectContext) throws -> WalletEntity? {
        let fetchRequest: NSFetchRequest<WalletEntity> = NSFetchRequest(entityName: "WalletEntity")
        return try context.fetch(fetchRequest).first
    }

    func currency(forAcronym acronym: String) -> CurrencyEntity? {
        return self.currencies?.filter({
            $0.acronym == acronym
        }).first
    }

    func currency(forIndex index: Int) -> CurrencyEntity? {
        guard let currencies = self.currencies else { return nil }
        if index >= currencies.count { return nil }
        let currencyIndex = currencies.index(currencies.startIndex, offsetBy: index)
        return currencies[currencyIndex]
    }

    func hasAtLeast(funds: Double, ofCurrencyAcronym acronym: String) -> Bool {
        guard let walletCurrencyAmmount = self.currency(forAcronym: acronym)?.value else {
            return false
        }
        return walletCurrencyAmmount >= funds
    }

    func add(ammount: Double, forCurrencyAcronym acronym: String, withName name: String) throws {
        guard var currencies = self.currencies else { return }
        guard let context: NSManagedObjectContext = self.managedObjectContext else { return }
        let walletCurrencyAmmount: Double
        if let currency = self.currency(forAcronym: acronym) {
            walletCurrencyAmmount = currency.value
        } else {
            walletCurrencyAmmount = 0.0
        }
        if let index = currencies.index(where: { $0.acronym == acronym }) {
            let currency: CurrencyEntity = currencies.remove(at: index)
            context.delete(currency)
        }
        let newCurrencyValue: CurrencyEntity = CurrencyEntity(context: context)
        newCurrencyValue.acronym = acronym
        newCurrencyValue.value = walletCurrencyAmmount + ammount
        newCurrencyValue.name = name

        currencies.insert(newCurrencyValue)

        try context.save()
    }

    func subtract(ammount: Double, ofCurrencyAcronym acronym: String, withName name: String) throws {
        try self.add(ammount: ammount * -1, forCurrencyAcronym: acronym, withName: name)
    }
}
