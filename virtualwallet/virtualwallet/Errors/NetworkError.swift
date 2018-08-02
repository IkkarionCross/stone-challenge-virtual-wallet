//
//  NetworkError.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum NetworkError: AppError, Equatable {
    case invalidDataReceived(requestDescription: String)
    case serverError(statusCode: String, message: String)

    var title: String {
        switch self {
        case .invalidDataReceived:
            return "Dados recebidos inválidos"
        case .serverError:
            return "Erro ao realizar a requisição"
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidDataReceived(let requestDescription):
            var description: String = requestDescription
            if !requestDescription.isEmpty {
                description.insert(" ", at: description.startIndex)
            }
            return "O servidor respondeu com dados inválidos ao consultar o serviço\(description)."
        case .serverError(let statusCode, let message):
            var errorCode: String = statusCode
            if !statusCode.isEmpty {
                errorCode.append(":")
            }
            return "O servidor respondeu com erro: \(statusCode): \(message)"
        }
    }
}
