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

}

extension Array where Element == QuotationEntity {
    func quotation(forCurrency acronym: String) -> QuotationEntity? {
        return self.filter({ $0.acronym == acronym }).first
    }
}
