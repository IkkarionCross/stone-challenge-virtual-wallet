//
//  UpdateCurrencyPropertiesOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

class UpdateCentralBankCurrency: CustomOperation {
    enum UpdateCurrencyInfoKeys: String {
        case quotations
    }

    private let service: RESTService

    private var invalidDataError: NetworkError {
        return NetworkError.invalidDataReceived(requestDescription: self.service.requestDescription())
    }

    init(service: RESTService) {
        self.service = service
        super.init()
        self.title = "Atualizar valores monetários"
    }

    override func main() {
        self.service.retrieveData { (json, error) in
            if let error = error {
                self.finish(withError: error)
                return
            }

            guard let quotationList: [[String: Any]] = json?[QuotationListKey.value.rawValue] as? [[String: Any]] else {
                self.finish(withError: self.invalidDataError)
                return
            }

            let decoder: JSONDecoder = JSONDecoder()
            decoder.dateDecodingStrategy = self.service.decodeDateStrategy()

            if let quotationListData: Data = try? JSONSerialization.data(withJSONObject: quotationList, options: []),
                let parsedQuotations: [JSONQuotation] = try? decoder.decode([JSONQuotation].self,
                                                                            from: quotationListData) {
                self.finish(withInfo: [UpdateCurrencyInfoKeys.quotations.rawValue: parsedQuotations])
            } else {
                self.finish(withError: JSONError.parseError)
            }
        }
    }
}
