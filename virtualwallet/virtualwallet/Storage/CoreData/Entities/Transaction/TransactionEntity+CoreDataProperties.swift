//
//  TransactionEntity+CoreDataProperties.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var fromCurrencyAcronym: String?
    @NSManaged public var toCurrencyAcronym: String?
    @NSManaged public var value: Double
    @NSManaged public var quotationUsed: QuotationEntity?
    @NSManaged public var wallet: WalletEntity?

}
