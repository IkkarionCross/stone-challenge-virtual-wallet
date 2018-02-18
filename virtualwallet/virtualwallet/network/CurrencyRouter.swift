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
    case retrieveQuotationToday(currencyAcronym: String)
    
    var method: HTTPMethod {
        switch self {
        case .retrieveQuotationToday:
            return .get
        }
    }

    private var urlItems: (path: String, parameters: Parameters?) {
        switch self {
        case .retrieveQuotationToday(let currencyAcronym):
            return (path:
                "/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)", ["@moeda": "'\(currencyAcronym)'",
                               "@dataCotacao": "'\(Date().formattedWith(format: "MM-dd-yyyy"))'",
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
        case .retrieveQuotationToday(let currencyAcronym):
            return "Cotação do(a) \(currencyAcronym)"
        }
    }
}
