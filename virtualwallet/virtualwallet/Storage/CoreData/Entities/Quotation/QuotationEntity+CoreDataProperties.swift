//
//  QuotationEntity+CoreDataProperties.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//
//

import Foundation
import CoreData

extension QuotationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuotationEntity> {
        return NSFetchRequest<QuotationEntity>(entityName: "QuotationEntity")
    }

    @NSManaged public var acronym: String
    @NSManaged public var buyPrice: Double
    @NSManaged public var reportType: String?
    @NSManaged public var sellPrice: Double
    @NSManaged public var timeStamp: Date?
    @NSManaged public var currency: CurrencyEntity
    @NSManaged public var transaction: NSSet?

}

// MARK: Generated accessors for transaction
extension QuotationEntity {

    @objc(addTransactionObject:)
    @NSManaged public func addToTransaction(_ value: TransactionEntity)

    @objc(removeTransactionObject:)
    @NSManaged public func removeFromTransaction(_ value: TransactionEntity)

    @objc(addTransaction:)
    @NSManaged public func addToTransaction(_ values: NSSet)

    @objc(removeTransaction:)
    @NSManaged public func removeFromTransaction(_ values: NSSet)

}
