//
//  CurrencyRouter.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

enum CurrencyRouter: URLRequestConvertible {
    case checkQuotationToday(currencyAcronym: String)

    var method: HTTPMethod {
        switch self {
        case .checkQuotationToday:
            return .get
        }
    }

    private var urlItems: (path: String, parameters: Parameters?) {
        switch self {
        case .checkQuotationToday(let currencyAcronym):
            return (path:
                "/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)", ["moeda": "\(currencyAcronym)",
                               "dataCotacao": "02-17-2018",
                               "format": "json"])
        }
    }

    func asURLRequest() throws -> URLRequest {
        let urlItems = self.urlItems

        let url = try BaseRouter.baseBCDURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(urlItems.path))
        urlRequest.httpMethod = method.rawValue

        return try URLEncoding.default.encode(urlRequest, with: urlItems.parameters)
    }
}
