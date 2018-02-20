//
//  UpdateCurrencyPropertiesOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import Alamofire

class UpdateCurrencyPropertiesOperation: CustomOperation {
    private let service: RESTService

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
                self.finish(withError: NetworkError.invalidDataReceived(requestDescription: ""))
                return
            }

            if let quotationListData = try? JSONSerialization.data(withJSONObject: quotationList, options: []),
                let parsedQuotations = try? JSONDecoder().decode([JSONQuotation].self, from: quotationListData) {

                self.finish(withInfo: ["quotations": parsedQuotations])
                print(parsedQuotations)
            } else {
                self.finish(withError: JSONError.parseError)
            }
        }
    }
}
