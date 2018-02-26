//
//  UpdateDigitalCurrencyOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class UpdateDigitalCurrencyOperation: CustomOperation {
    private let service: RESTService

    private var invalidDataError: NetworkError {
        return NetworkError.invalidDataReceived(requestDescription: self.service.requestDescription())
    }

    init(service: RESTService) {
        self.service = service
        super.init()
        self.title = "Atualizar moedas digitais"
    }

    override func main() {
        self.service.retrieveData { (json, error) in

        }
    }
}
