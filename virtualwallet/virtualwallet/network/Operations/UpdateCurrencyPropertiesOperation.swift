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
    private let service: RESTService<[String: Any]>

    init(service: RESTService<[String: Any]>) {
        self.service = service
        super.init()
        self.title = "Atualizar valores monetários"
    }

    override func main() {
        self.service.retrieveData { (jsonString, error) in
            if let error = error {
                self.operationDidFinish?(error, nil)
                self.finish()
                return
            }

            guard let jsonString = jsonString else {
                self.operationDidFinish?(NetworkError.invalidDataReceived(requestDescription: ""), nil)
                return
            }
            self.operationDidFinish?(nil, ["data": jsonString])
            self.finish()
        }
    }
}
