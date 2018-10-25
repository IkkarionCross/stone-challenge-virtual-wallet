//
//  UpdateDigitalCurrencyOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class FetchDigitalCurrencyOperation: CustomOperation {
    typealias CompletionType = [QuotationEntity]

    var operationDidStart: ((String) -> Void)?
    var operationDidFinish: ((Completion<[QuotationEntity]>) -> Void)?

    var dataContainer: DataContainer?
    private let currencyType: SupportedCurrencies

    init(currencyType: SupportedCurrencies, container: DataContainer? = nil) {
        self.dataContainer = container
        self.currencyType = currencyType
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

                guard let context = self?.dataContainer?.walletDataContext else {
                    self?.finish(withError: OperationError.failed(reason: "invalid data context"))
                    return
                }

                guard let currencyAcronym = self?.currencyType.rawValue else {
                    self?.finish(withError: OperationError.failed(reason: "invalid currency acronym"))
                    return
                }

                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONTicker.decodeDateStrategy()
                guard let tickerData: Data = try? JSONSerialization.data(withJSONObject: tickerJson, options: []),
                    let ticker: JSONTicker = try? decoder.decode(JSONTicker.self, from: tickerData) else {
                    self?.finish(withError: JSONError.parseError)
                    return
                }
                do {
                    let quotation: QuotationEntity = ticker.toEntity(inContext: context, acronym: currencyAcronym)
                    try context.save()
                    self?.finish(withInfo: [quotation])
                } catch {
                    self?.finish(withError: OperationError.failed(reason: error.localizedDescription))
                }
            }
        }
    }
}

extension FetchDigitalCurrencyOperation: ObservableOperation {}
