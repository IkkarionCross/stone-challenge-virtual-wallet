//
//  CurrencyEntity+CoreDataProperties.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyEntity> {
        return NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity")
    }

    @NSManaged public var acronym: String?
    @NSManaged public var name: String?
    @NSManaged public var value: Double
    @NSManaged public var quotation: QuotationEntity?
    @NSManaged public var wallet: WalletEntity?

}
