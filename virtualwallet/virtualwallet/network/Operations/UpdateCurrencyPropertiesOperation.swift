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
        self.service.retrieveData(queue: DispatchQueue.global()) { (jsonString, error) in
            
        }
    }
}
