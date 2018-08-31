//
//  UpdateCurrencyPropertiesOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

class FetchCentralBankCurrency: CustomOperation {
    typealias CompletionType = [QuotationEntity]

    var operationDidStart: ((String) -> Void)?
    var operationDidFinish: ((Completion<[QuotationEntity]>) -> Void)?

    var dataContainer: DataContainer?
    private let currencyType: SupportedCurrencies

    init(currencyType: SupportedCurrencies) {
        self.currencyType = currencyType
        super.init()
        self.title = "Atualizar valores monetários"
    }

    func buildRequest() -> RESTService {
        let usdRequest: CentralBankRouter =
            CentralBankRouter.recentQuotationFor(currencyAcronym: SupportedCurrencies.USD.rawValue)
        return RESTService(request: usdRequest,
                                   queue: DispatchQueue.global())
    }
    
    private func decodeToJSONQuotation(quotationList: [[String: Any]]) throws -> [JSONQuotation] {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONQuotation.decodeDateStrategy()
        let quotationListData: Data = try JSONSerialization.data(withJSONObject: quotationList, options: [])
        return try decoder.decode([JSONQuotation].self, from: quotationListData)
    }

    override func main() {
        let service: RESTService = buildRequest()
        service.retrieveData { [weak self] (result) in
            switch result {
            case let .failure(error):
                self?.finish(withError: error)
            case let .success(json):
                guard let quotationList: [[String: Any]] =
                    json[QuotationListKey.value.rawValue] as? [[String: Any]] else {
                    self?.finish(withError:
                        NetworkError.invalidDataReceived(requestDescription: service.requestDescription()))
                    return
                }
                do {
                    guard let parsedQuotations: [JSONQuotation] = try self?.decodeToJSONQuotation(quotationList: quotationList) else {
                        self?.finish(withError: OperationError.failed(reason: "invalid currency type"))
                        return
                    }
                    guard let currenyAcronym = self?.currencyType.rawValue else {
                        self?.finish(withError: OperationError.failed(reason: "invalid currency type"))
                        return
                    }
                    guard let context = self?.dataContainer?.walletDataContext else {
                        self?.finish(withError: OperationError.failed(reason: "invalid data context"))
                        return
                    }
                    
                    let quotations: [QuotationEntity] = parsedQuotations.toEntity(acronym: currenyAcronym, context: context)
                    self?.finish(withInfo: quotations)
                } catch {
                    self?.finish(withError: JSONError.parseError)
                }
            }
        }
    }
}

extension FetchCentralBankCurrency: Persistable {}
extension FetchCentralBankCurrency: ObservableOperation {}
