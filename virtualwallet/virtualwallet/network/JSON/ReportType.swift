//
//  ReportType.swift
//  virtualwallet
//
//  Created by Victor Amaro on 24/10/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum QuotationReportType: String, Codable {
    case open = "Abertura"
    case intermediary = "Intermediário"
    case close = "Fechamento PTAX"
    case ticker = "Ticker"
}
