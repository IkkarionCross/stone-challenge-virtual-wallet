//
//  CurrencyRouter.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

enum CentralBankRouter: Router {
    case recentQuotationFor(currencyAcronym: String)

    var method: HTTPMethod {
        switch self {
        case .recentQuotationFor:
            return .get
        }
    }

    var urlItems: (path: String, parameters: Parameters?) {
        switch self {
        case .recentQuotationFor(let currencyAcronym):
            return (path:
                "/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)", ["@moeda": "'\(currencyAcronym)'",
                               "@dataCotacao": "'\(recentQuotationDate().formattedWith(format: "MM-dd-yyyy"))'",
                               "$format": "json"])
        }
    }

    var requestDescription: String {
        switch self {
        case .recentQuotationFor(let currencyAcronym):
            return "Cotação do(a) \(currencyAcronym)"
        }
    }

    /*
     Get a valid date for query quotations
     */
    func recentQuotationDate() -> Date {
        let calendar: Calendar = Calendar.current
        let today: Date = Date()
        guard calendar.isDateInWeekend(today) else {
            return today
        }
        guard let lastFriday: Date = today.lastFriday() else {
            return today
        }
        return lastFriday
    }

    func asURLRequest() throws -> URLRequest {
        let url = try BaseRouter.baseBCDURL.asURL()
        return try self.buildRequest(fromBaseURL: url)
    }
}
