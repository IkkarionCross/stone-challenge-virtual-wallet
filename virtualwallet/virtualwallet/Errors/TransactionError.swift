//
//  TransactionError.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum TransactionError: AppError, Equatable {
    case notEnoughFunds(ofCurrency: String)
    case unrecognezedTransactiontype
    case noQuotations
    case canNotCalculateTotalValue
    case unrecognizedCurrency
    case unknownError(description: String)

    var title: String {
        switch self {
        case .notEnoughFunds:
            return "Fundos insuficientes"
        case .unrecognezedTransactiontype:
            return "Tipo de Transação"
        case .noQuotations:
            return "Cotações"
        case .canNotCalculateTotalValue, .unrecognizedCurrency, .unknownError:
            return "Transação"
        }
    }

    var errorDescription: String? {
        switch self {
        case .notEnoughFunds(let currency):
            return "Fundos para \(currency) não são suficientes para realizar a transação."
        case .unrecognezedTransactiontype:
            return "Tipo de transação selecionado não é suportado!"
        case .noQuotations:
            return "Não existem cotações salvas para entre a moeda de compra e a moeda de troca!"
        case .canNotCalculateTotalValue:
            return "Não foi possível efeturar a transação, o valor total não foi calculado."
        case .unrecognizedCurrency:
            return "A moeda da transação não foi reconhecida."
        case let .unknownError(description):
            return "Ocorreu um erro na transação: \(description)"
        }
    }
}
