//
//  BitcoinMarketRouter.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

enum BitcoinMarketRouter: URLRequestConvertible {
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
    
    func asURLRequest() throws -> URLRequest {
        let urlItems = self.urlItems
        
        let url = try BaseRouter.baseBitcoinMarketURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(urlItems.path))
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: urlItems.parameters)
    }
}
