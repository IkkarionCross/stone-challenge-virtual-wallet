//
//  CoreDataError.swift
//  virtualwallet
//
//  Created by Victor Amaro on 29/10/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum CoreDataError: String, AppError {
    case invalidContext

    var title: String {
        switch self {
        case .invalidContext:
            return "Virtual Wallet"
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidContext:
            return "O contexto é inválido."
        }
    }
}
