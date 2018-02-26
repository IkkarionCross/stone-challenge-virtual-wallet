//
//  BaseRouter.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

enum BaseRouter {
    static let baseBCDHost: String = "olinda.bcb.gov.br"
    static var baseBCDURL: String {
        return "https://\(BaseRouter.baseBCDHost)/olinda/servico/PTAX/versao/v1"
    }

    static let bitcoinMarketHost: String = "www.mercadobitcoin.net"
    static var baseBitcoinMarketURL: String {
        return "https://\(BaseRouter.bitcoinMarketHost)/api/"
    }
}
