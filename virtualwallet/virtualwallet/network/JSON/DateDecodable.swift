//
//  DateDecodable.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol DateDecodable {
    static func decodeDateStrategy() -> JSONDecoder.DateDecodingStrategy
    static func encodeDateStrategy() -> JSONEncoder.DateEncodingStrategy
}
