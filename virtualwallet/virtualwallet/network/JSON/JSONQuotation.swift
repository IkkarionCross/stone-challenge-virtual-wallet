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

enum QuotationReportType: String, Codable {
    case open = "Abertura"
    case intermediary = "Intermediário"
    case close = "Fechamento PTAX"
}

struct JSONQuotation: Decodable, DateDecodable {
    let buyParity: Double
    let sellParity: Double
    let buyQuotation: Double
    let sellQuotation: Double
    let timeStamp: Date
    let reportType: QuotationReportType

    enum CodingKeys: String, CodingKey {
        case buyParity = "paridadeCompra"
        case sellParity = "paridadeVenda"
        case buyQuotation = "cotacaoCompra"
        case sellQuotation = "cotacaoVenda"
        case timeStamp = "dataHoraCotacao"
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

    func toEntity(acronym: String, context: NSManagedObjectContext) -> QuotationEntity {
        let quotation: QuotationEntity = QuotationEntity(context: context)
        quotation.acronym = acronym
        quotation.buyParity = buyParity
        quotation.sellParity = sellParity
        quotation.sellPrice = sellQuotation
        quotation.buyPrice = buyQuotation
        quotation.timeStamp = timeStamp
        quotation.reportType = reportType.rawValue

        return quotation
    }
}

extension Array where Element == JSONQuotation {
    func toEntity(acronym: String, context: NSManagedObjectContext) -> [QuotationEntity] {
        var quotations: [QuotationEntity] = []
        for jsonQuotation in self {
            let quotation: QuotationEntity = jsonQuotation.toEntity(acronym: acronym, context: context)
            quotations.append(quotation)
        }
        return quotations
    }
}
