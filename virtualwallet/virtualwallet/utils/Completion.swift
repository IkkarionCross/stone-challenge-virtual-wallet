//
//  Completion.swift
//  virtualwallet
//
//  Created by victor-mac on 22/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum Completion<T> {
    case success(T)
    case failure(AppError)
}
