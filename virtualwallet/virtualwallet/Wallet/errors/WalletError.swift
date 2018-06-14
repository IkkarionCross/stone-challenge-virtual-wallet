//
//  TransactionError.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum WalletError: AppError, Equatable {
    case currencyNotFound(forAcronym: String)

    var title: String {
        switch self {
        case .currencyNotFound:
            return "Moeda não encontrada"
        }
    }

    var errorDescription: String? {
        switch self {
        case .currencyNotFound(let acronym):
            return "A operação não foi realizada. A moeda de sigla \(acronym) não foi encontrada em sua carteira."
        }
    }
}
