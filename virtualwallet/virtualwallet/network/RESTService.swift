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
    private var urlConvertible: URLRequestConvertible
    
    init(request: URLRequestConvertible) {
        self.urlConvertible = request
    }
    
    func makeRequest(queue: DispatchQueue?, completion: @escaping (_ jsonString: String?, _ error: AppError?) -> Void) {
        Alamofire.request(self.urlConvertible)
            .validate(statusCode: 200...299)
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    if let JSONData = response.result.value as? String {
                        completion(JSONData, nil)
                    } else {
//                        let handlerError = DataHandlerError.invalidDataReceived
                        completion(nil, nil)
                    }
                case .failure:
//                    let message = response.error?.localizedDescription
//                    let handlerError = DataHandlerError.serverError(statusCode: response.response?.statusCode ?? -1, message: message!)
                    completion(nil, nil)
                }
        }
    }
}
