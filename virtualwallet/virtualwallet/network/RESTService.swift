//
//  NetworkService.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

struct RESTService {
    private var urlRequest: URLRequestConvertible
    
    init(request: URLRequestConvertible) {
        self.urlRequest = request
    }
    
    func makeRequest(queue: DispatchQueue?, completion: @escaping (_ jsonString: String?, _ error: AppError?) -> Void) {
        Alamofire.request(self.urlRequest)
            .validate(statusCode: 200...299)
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    if let JSONData = response.result.value as? String {
                        completion(JSONData, nil)
                    } else {
                        if let requestDescription = (self.urlRequest as? URLDescriptor)?.requestDescription {
                            completion(nil,
                                       NetworkError.invalidDataReceived(requestDescription: requestDescription))
                        }
                    }
                case .failure:
                    let statusCode: String
                    if let code = response.response?.statusCode {
                        statusCode = String(code)
                    } else {
                        statusCode = ""
                    }
                    let message = response.error?.localizedDescription ?? ""
                    let serverError = NetworkError.serverError(statusCode: statusCode, message: message)
                    completion(nil, serverError)
                }
        }
    }
}
