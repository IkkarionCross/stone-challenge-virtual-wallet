//
//  JSONQuotation.swift
//  virtualwallet
//
//  Created by victor-mac on 19/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import CoreData

enum QuotationListKey: String {
    case value
}

struct JSONQuotation: Decodable, DateDecodable {
    let buyParity: Double
    let sellParity: Double
    let buy: Double
    let sell: Double
    let date: Date
    let reportType: QuotationReportType

    enum CodingKeys: String, CodingKey {
        case buyParity = "paridadeCompra"
        case sellParity = "paridadeVenda"
        case buy = "cotacaoCompra"
        case sell = "cotacaoVenda"
        case date = "dataHoraCotacao"
        case reportType = "tipoBoletim"
    }

    private static func dateFormatter() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }

    static func decodeDateStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .formatted(dateFormatter())
    }

    static func encodeDateStrategy() -> JSONEncoder.DateEncodingStrategy {
        return .formatted(dateFormatter())
    }

}

extension Array where Element == JSONQuotation {
    func toEntity(fromAcronym: String, toAcronym: String, context: NSManagedObjectContext) -> [QuotationEntity] {
        var quotations: [QuotationEntity] = []
        for jsonQuotation in self {
            let quotation: QuotationEntity =
                jsonQuotation.toEntity(inContext: context,
                                       fromAcronym: fromAcronym,
                                       toAcronym: toAcronym)
            quotations.append(quotation)
        }
        return quotations
    }
}

extension JSONQuotation: Quotation {}
