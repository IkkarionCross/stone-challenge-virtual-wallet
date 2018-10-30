//
//  AppError.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol AppError: LocalizedError {
    var title: String {get}
}

extension AppError where Self: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription &&
            rhs.title == lhs.title
    }
}
