//
//  NetworkError.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum NetworkError: AppError {
    case invalidDataReceived(requestDescription: String)
    
    var title: String {
        switch self {
        case .invalidDataReceived:
            return "Dados recebidos inválidos"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidDataReceived(let requestDescription):
            var description: String = requestDescription
            if !requestDescription.isEmpty {
                description = " " + requestDescription
            }
            return "O servidor respondeu com dados inválidos ao consultar o serviço\(description)."
        }
    }
}
