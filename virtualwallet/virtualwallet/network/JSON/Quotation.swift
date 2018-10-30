//
//  Quotation.swift
//  virtualwallet
//
//  Created by Victor Amaro on 29/10/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import CoreData

protocol Quotation {
    var sell: Double {get}
    var buy: Double {get}
    var date: Date {get}
    var reportType: QuotationReportType {get}
}

extension Quotation {
    func toEntity(inContext context: NSManagedObjectContext,
                  fromAcronym: String, toAcronym: String) -> QuotationEntity {
        let quotationEntity: QuotationEntity = QuotationEntity(context: context)
        quotationEntity.toAcronym = toAcronym
        quotationEntity.fromAcronym = fromAcronym
        quotationEntity.sellPrice = sell
        quotationEntity.buyPrice = buy
        quotationEntity.timeStamp = date
        quotationEntity.reportType = reportType.rawValue
        return quotationEntity
    }
}
