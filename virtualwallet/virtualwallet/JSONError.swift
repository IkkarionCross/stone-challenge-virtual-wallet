//
//  JSONError.swift
//  virtualwallet
//
//  Created by victor-mac on 19/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum JSONError: AppError {
    case parseError(message: String)

    var title: String {
        switch self {
        case .parseError:
            return "Erro ao tentar ler informações"
        }
    }

    var errorDescription: String? {
        switch self {
        case .parseError(let message):
            return "O servidor respondeu com informações que este aplicativo não consegue ler. Erro: \(message)"
        }
    }
}
