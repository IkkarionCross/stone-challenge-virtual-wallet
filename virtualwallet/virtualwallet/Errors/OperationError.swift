//
//  OperationError.swift
//  virtualwallet
//
//  Created by victor-mac on 30/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum OperationError: AppError {
    case failed(reason: String)
    
    var title: String {
        switch self {
        case .failed:
            return "The operation has failed"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case let .failed(reason):
            return "The operation has failed: \(reason)"
        }
    }
}
