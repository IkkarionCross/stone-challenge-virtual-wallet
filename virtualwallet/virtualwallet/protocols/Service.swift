//
//  Service.swift
//  virtualwallet
//
//  Created by victor-mac on 18/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol Service {
    associatedtype DataType
    func retrieveData(completion: @escaping (_ data: DataType?, _ error: AppError?) -> Void)
}
