//
//  UpdateDigitalCurrencyOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class FetchDigitalCurrencyOperation: CustomOperation {
    typealias CompletionType = JSONTicker

    var operationDidStart: ((String) -> Void)?
    var operationDidFinish: ((Completion<JSONTicker>) -> Void)?

    override init() {
        super.init()
        self.title = "Atualizar moedas digitais"
    }

    func buildRequest() -> RESTService {
        let bitcoinRequest: BitcoinMarketRouter =
            BitcoinMarketRouter.recentQuotationFor(currency:
            SupportedCurrencies.BTC.rawValue)
        return RESTService(request: bitcoinRequest, queue: DispatchQueue.global())
    }

    override func main() {
        let service: RESTService = buildRequest()
        service.retrieveData { [weak self] (result) in
            switch result {
            case let .failure(error):
                self?.finish(withError: error)
            case let .success(json):
                guard let tickerJson: [String: Any] = json[JSONTickerKey.ticker.rawValue] as? [String: Any] else {
                    self?.finish(withError:
                        NetworkError.invalidDataReceived(requestDescription: service.requestDescription()))
                    return
                }

                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONTicker.decodeDateStrategy()
                if let tickerData: Data = try? JSONSerialization.data(withJSONObject: tickerJson, options: []),
                    let ticker: JSONTicker = try? decoder.decode(JSONTicker.self, from: tickerData) {
                    self?.finish(withInfo: ticker)
                } else {
                    self?.finish(withError: JSONError.parseError)
                }
            }
        }
    }
}

extension FetchDigitalCurrencyOperation: ObservableOperation {}
