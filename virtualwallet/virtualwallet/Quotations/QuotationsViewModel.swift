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

    private var quotations: [QuotationEntity]
    var service: QuotationServant
    var dataContainer: DataContainer?
    weak var delegate: QuotationsDelegate?

    init(quotations: [QuotationEntity], dataContainer: DataContainer) {
        self.dataContainer = dataContainer

        self.service = QuotationsService(dataContainer: dataContainer)
        self.quotations = quotations
    }

    func updateQuotationsFromNetwork() {
        self.service.fetchQuotations(fromCurrencyProvider: .centralBank, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.delegate?.onQuotationsUpdated(error: error)
                }
            case let .success(quotations):
                DispatchQueue.main.async {
                    self?.delegate?.onQuotationsUpdated(error: nil)
                }
                self?.quotations.append(contentsOf: quotations)
            }
        })
    }

    func allQuotations() -> [QuotationEntity] {
        return self.quotations
    }

    func quotation(at indexPath: IndexPath) -> QuotationEntity {
        return self.quotations[indexPath.row]
    }
}

extension QuotationsViewModel: Persistable {}
