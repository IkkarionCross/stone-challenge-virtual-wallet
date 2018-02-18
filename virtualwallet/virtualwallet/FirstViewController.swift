//
//  FirstViewController.swift
//  virtualwallet
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let operationQueue: OperationQueue = OperationQueue()
    var updateOperation: UpdateCurrencyPropertiesOperation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlRequest: CurrencyRouter = CurrencyRouter.retrieveQuotationToday(currencyAcronym: "USD")
        let service: RESTService<[String: Any]> = RESTService<[String: Any]>(request: urlRequest,
                                                               queue: DispatchQueue.global())
        updateOperation = UpdateCurrencyPropertiesOperation(service: service)

        operationQueue.addOperation(updateOperation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
