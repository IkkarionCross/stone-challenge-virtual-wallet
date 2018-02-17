//
//  TransactionError.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum TransactionError: AppError {
    case notEnoughFunds(ofCurrency: String)

    var title: String {
        switch self {
        case .notEnoughFunds:
            return "Fundos insuficientes"
        }
    }

    var errorDescription: String? {
        switch self {
        case .notEnoughFunds(let currency):
            return "Fundos para \(currency) não são suficientes para realizar a transação."
        }
    }
}

extension TransactionError: Equatable {
    static func == (lhs: TransactionError, rhs: TransactionError) -> Bool {
        return lhs.title == rhs.title &&
            lhs.localizedDescription == rhs.localizedDescription
    }

    static func == (lhs: Error, rhs: TransactionError) -> Bool {
        return lhs is AppError &&
            lhs.localizedDescription == rhs.localizedDescription
    }

    static func == (lhs: TransactionError, rhs: Error) -> Bool {
        return rhs is AppError &&
            lhs.localizedDescription == rhs.localizedDescription
    }
}
