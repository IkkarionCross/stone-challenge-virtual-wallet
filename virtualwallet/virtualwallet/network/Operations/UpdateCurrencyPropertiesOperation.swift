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
    
    init(router: CurrencyRouter) {
        super.init()
        self.title = "Atualizar valores monetários"
    }
    
    override func main() {
        Alamofire.request(try! CurrencyRouter.retrieveQuotationToday(currencyAcronym: "USD").asURLRequest()).responseJSON(queue: DispatchQueue.global()) { (response) in
            
        }
    }
}
