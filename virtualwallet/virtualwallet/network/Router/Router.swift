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
    var requestDescription: String {get}
}

extension Router {
    func buildRequest(fromBaseURL baseURL: URL) throws -> URLRequest {
        let urlItems = self.urlItems

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(urlItems.path))
        urlRequest.httpMethod = method.rawValue

        return try URLEncoding.default.encode(urlRequest, with: urlItems.parameters)
    }
}
