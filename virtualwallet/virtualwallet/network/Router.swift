//
//  Router.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
    var urlItems: (path: String, parameters: Parameters?) {get}
    var method: HTTPMethod {get}
    func encodeURL(fromBaseURL baseURL: String)
}

extension Router {
    func buildRequest(fromBaseURL baseURL: String) throws -> URLRequest {
        let urlItems = self.urlItems
        
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(urlItems.path))
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: urlItems.parameters)
    }
}
