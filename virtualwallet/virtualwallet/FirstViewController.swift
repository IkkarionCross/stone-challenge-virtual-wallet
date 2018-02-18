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
        guard let currencyOnDate = Date().add(days: -2) else { return }
        let urlRequest: CurrencyRouter = CurrencyRouter.retrieveQuotationFor(currencyAcronym: "USD",
                                                                             date: currencyOnDate)
        let service: RESTService = RESTService(request: urlRequest,
                                                               queue: DispatchQueue.global())
        updateOperation = UpdateCurrencyPropertiesOperation(service: service)

        operationQueue.addOperation(updateOperation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
