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
    private let service: RESTService<String>
    
    init(service: RESTService<String>) {
        self.service = service
        super.init()
        self.title = "Atualizar valores monetários"
    }
    
    override func main() {
        self.service.retrieveData { (jsonString, error) in
            
        }
    }
}
