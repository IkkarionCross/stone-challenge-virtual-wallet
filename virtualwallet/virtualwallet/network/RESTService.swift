//
//  NetworkService.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

struct RESTService: Service {
    typealias DataType = [String: Any]
    private let urlRequest: URLRequestConvertible
    private let queue: DispatchQueue?

    init(request: URLRequestConvertible, queue: DispatchQueue?) {
        self.urlRequest = request
        self.queue = queue
    }

    func retrieveData(completion: @escaping (_ data: DataType?, _ error: AppError?) -> Void) {
        Alamofire.request(self.urlRequest)
            .validate(statusCode: 200...299)
            .responseJSON(queue: self.queue, options: JSONSerialization.ReadingOptions.allowFragments) { response in
                switch response.result {
                case .success:
                    if let JSONData = response.result.value as? DataType {
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

    func requestDescription() -> String {
        guard let descriptor: URLDescriptor = self.urlRequest as? URLDescriptor else {
            return ""
        }
        return descriptor.requestDescription
    }

    private func RESTDateFormatter() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }

    func decodeDateStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .formatted(RESTDateFormatter())
    }

    func encodeDateStrategy() -> JSONEncoder.DateEncodingStrategy {
        return .formatted(RESTDateFormatter())
    }
}
