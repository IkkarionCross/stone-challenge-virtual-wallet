//
//  QuotationEntity+CoreDataClass.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//
//

import Foundation
import CoreData

@objc(QuotationEntity)
public class QuotationEntity: NSManagedObject {

    var invertedBuyPrice: Double {
        return 1.0 / buyPrice
    }

    var invertedSellPrice: Double {
        return 1.0 / sellPrice
    }

}

extension Array where Element == QuotationEntity {
    func quotation(fromCurrency: String, toCurrency: String) -> QuotationEntity? {
        return self.filter({ $0.fromAcronym == fromCurrency &&
            $0.toAcronym == toCurrency
        }).first
    }
}
