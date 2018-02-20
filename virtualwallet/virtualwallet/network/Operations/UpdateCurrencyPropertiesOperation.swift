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
                self.operationDidFinish?(error, nil)
                self.finish()
                return
            }

            guard let json = json else {
                self.operationDidFinish?(NetworkError.invalidDataReceived(requestDescription: ""), nil)
                self.finish()
                return
            }

            guard let quotationList: [[String: Any]] = json["value"] as? [[String: Any]] else {
                self.operationDidFinish?(NetworkError.invalidDataReceived(requestDescription: ""), nil)
                self.finish()
                return
            }

            do {
                let quotationListData = try JSONSerialization.data(withJSONObject: quotationList, options: [])
                let parsedQuotations = try JSONDecoder().decode([JSONQuotation].self, from: quotationListData)

                self.operationDidFinish?(nil, ["quotations": parsedQuotations])
                self.finish()
                print(parsedQuotations)
            } catch {
                self.operationDidFinish?(JSONError.parseError(message: error.localizedDescription), nil)
                self.finish()
            }
        }
    }
}
