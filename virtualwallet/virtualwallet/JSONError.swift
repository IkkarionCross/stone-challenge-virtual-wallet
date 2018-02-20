//
//  JSONError.swift
//  virtualwallet
//
//  Created by victor-mac on 19/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum JSONError: AppError, Equatable {
    case parseError

    var title: String {
        switch self {
        case .parseError:
            return "Erro ao tentar ler informações"
        }
    }

    var errorDescription: String? {
        switch self {
        case .parseError:
            return "O servidor respondeu com informações que este aplicativo não consegue ler."
        }
    }
}
