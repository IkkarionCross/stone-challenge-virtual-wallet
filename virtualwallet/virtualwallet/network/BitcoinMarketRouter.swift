//
//  BitcoinMarketRouter.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

enum BitcoinMarketRouter: Router {
    case recentQuotationFor(currency: String)

    var method: HTTPMethod {
        switch self {
        case .recentQuotationFor:
            return .get
        }
    }

    var urlItems: (path: String, parameters: Parameters?) {
        switch self {
        case .recentQuotationFor(let currency):
            return (path:
                "/\(currency)/ticker", [:])
        }
    }

    var requestDescription: String {
        switch self {
        case .recentQuotationFor(let currencyAcronym):
            return "Cotação do(a) \(currencyAcronym)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try BaseRouter.baseBitcoinMarketURL.asURL()
        return try self.buildRequest(fromBaseURL: url)
    }
}
