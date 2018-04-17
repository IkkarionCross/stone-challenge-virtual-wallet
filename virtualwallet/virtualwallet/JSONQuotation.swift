//
//  JSONQuotation.swift
//  virtualwallet
//
//  Created by victor-mac on 19/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

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
}
