//
//  JSONQuotation.swift
//  virtualwallet
//
//  Created by victor-mac on 19/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum QuotationListKey: String {
    case value = "value"
}

enum QuotationReportType: String, Codable {
    case open = "Abertura"
    case intermediary = "Intermediário"
    case close = "Fechamento PTAX"
}

struct JSONQuotation: Codable {
    let buyParity: Float
    let sellParity: Float
    let buyQuotation: Float
    let sellQuotation: Float
    let timeStamp: String
    let reportType: QuotationReportType

    enum CodingKeys: String, CodingKey {
        case buyParity = "paridadeCompra"
        case sellParity = "paridadeVenda"
        case buyQuotation = "cotacaoCompra"
        case sellQuotation = "cotacaoVenda"
        case timeStamp = "dataHoraCotacao"
        case reportType = "tipoBoletim"
    }
}
