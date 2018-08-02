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

    var title: String {
        switch self {
        case .notEnoughFunds:
            return "Fundos insuficientes"
        case .unrecognezedTransactiontype:
            return "Tipo de Transação"
        }
    }

    var errorDescription: String? {
        switch self {
        case .notEnoughFunds(let currency):
            return "Fundos para \(currency) não são suficientes para realizar a transação."
        case .unrecognezedTransactiontype:
            return "Tipo de transação selecionado não é suportado!"
        }
    }
}
