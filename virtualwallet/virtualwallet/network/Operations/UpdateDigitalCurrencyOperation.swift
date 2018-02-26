//
//  UpdateDigitalCurrencyOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class UpdateDigitalCurrencyOperation: CustomOperation {
    enum UpdateDigitalCurrencyKeys: String {
        case ticker
    }
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
            if let error = error {
                self.finish(withError: error)
                return
            }

            guard let tickerJson: [String: Any] = json?[JSONTickerKey.ticker.rawValue] as? [String: Any] else {
                self.finish(withError: self.invalidDataError)
                return
            }

            let decoder: JSONDecoder = JSONDecoder()
            decoder.dateDecodingStrategy = JSONTicker.decodeDateStrategy()
            if let tickerData: Data = try? JSONSerialization.data(withJSONObject: tickerJson, options: []),
                let ticker: JSONTicker = try? decoder.decode(JSONTicker.self, from: tickerData) {
                self.finish(withInfo: [UpdateDigitalCurrencyKeys.ticker.rawValue: ticker])
            } else {
                self.finish(withError: JSONError.parseError)
            }
        }
    }
}
