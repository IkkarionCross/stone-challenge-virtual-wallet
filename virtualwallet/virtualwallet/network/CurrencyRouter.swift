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
    case retrieveQuotationFor(currencyAcronym: String, date: Date)

    var method: HTTPMethod {
        switch self {
        case .retrieveQuotationFor:
            return .get
        }
    }

    private var urlItems: (path: String, parameters: Parameters?) {
        switch self {
        case .retrieveQuotationFor(let currencyAcronym, let date):
            return (path:
                "/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)", ["@moeda": "'\(currencyAcronym)'",
                               "@dataCotacao": "'\(date.formattedWith(format: "MM-dd-yyyy"))'",
                               "$format": "json"])
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

extension CurrencyRouter: URLDescriptor {
    var requestDescription: String {
        switch self {
        case .retrieveQuotationFor(let currencyAcronym):
            return "Cotação do(a) \(currencyAcronym)"
        }
    }
}
