//
//  QuotationsViewModel.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol QuotationsDelegate: class {
    func onQuotationsUpdated(error: AppError?)
}

class QuotationsViewModel {

    private var quotations: [JSONQuotation]
    private let operationQueue: OperationQueue

    weak var delegate: QuotationsDelegate?

    private var USDRequest: CentralBankRouter {
        return CentralBankRouter.recentQuotationFor(currencyAcronym: SupportedCurrencies.USD.rawValue)
    }

    init(quotations: [JSONQuotation]) {
        self.quotations = quotations
        self.operationQueue = OperationQueue()
    }

    func updateQuotationsFromNetwork() {
        let service: RESTService = RESTService(request: USDRequest,
                                               queue: DispatchQueue.global())

        let updateCurrencyFromBC: UpdateCurrencyPropertiesOperation =
            UpdateCurrencyPropertiesOperation(service: service)

        updateCurrencyFromBC.operationDidFinish = { error, info in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.delegate?.onQuotationsUpdated(error: error)
                }
                return
            }
            if let retrievedQuotations: [JSONQuotation] =
                info?[UpdateCurrencyPropertiesOperation.UpdateCurrencyInfoKeys.quotations.rawValue]
                    as? [JSONQuotation] {
                DispatchQueue.main.async {
                    self.delegate?.onQuotationsUpdated(error: nil)
                }
                self.quotations.append(contentsOf: retrievedQuotations)
            }
        }

        operationQueue.addOperation(updateCurrencyFromBC)
    }

    func allQuotations() -> [JSONQuotation] {
        return self.quotations
    }

    func quotation(at indexPath: IndexPath) -> JSONQuotation {
        return self.quotations[indexPath.row]
    }
}
