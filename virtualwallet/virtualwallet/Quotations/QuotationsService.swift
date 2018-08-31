//
//  QuotationsService.swift
//  virtualwallet
//
//  Created by victor-mac on 30/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol QuotationServant {
    func fetchQuotations(fromCurrencyProvider provider: CurrencyProvider,
                         completion: @escaping (_ result: Completion<[QuotationEntity]>)->Void)
}

class QuotationsService: QuotationServant {
    private var operationQueue: OperationQueue
    
    init() {
        self.operationQueue = OperationQueue()
    }
    
    func fetchQuotations(fromCurrencyProvider provider: CurrencyProvider,
                         completion: @escaping (_ result: Completion<[QuotationEntity]>)->Void) {
        let updateCurrencyFromBC: FetchCentralBankCurrency =
            FetchCentralBankCurrency(currencyType: SupportedCurrencies.USD)
        
        updateCurrencyFromBC.operationDidFinish = completion
        
        operationQueue.addOperation(updateCurrencyFromBC)
    }
}
