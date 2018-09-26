//
//  QuotationsService.swift
//  virtualwallet
//
//  Created by victor-mac on 30/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import CoreData
import Foundation

protocol QuotationServant {
    func fetchQuotations(fromCurrencyProvider provider: CurrencyProvider,
                         completion: @escaping (_ result: Completion<[QuotationEntity]>) -> Void)
    func hasQuotations(inContext context: NSManagedObjectContext,
                       forCurrency currency: String, inWallet wallet: WalletEntity?) throws -> Bool
}

class QuotationsService: QuotationServant {
    private var operationQueue: OperationQueue
    var dataContainer: DataContainer

    init(dataContainer: DataContainer) {
        self.dataContainer = dataContainer
        self.operationQueue = OperationQueue()
    }

    func fetchQuotations(fromCurrencyProvider provider: CurrencyProvider,
                         completion: @escaping (_ result: Completion<[QuotationEntity]>) -> Void) {
        switch provider {
        case .centralBank:
            let updateCurrencyFromBC: FetchCentralBankCurrency =
                FetchCentralBankCurrency(currencyType: SupportedCurrencies.USD,
                                         container: dataContainer)

            updateCurrencyFromBC.operationDidFinish = completion
            operationQueue.addOperation(updateCurrencyFromBC)
        default:
            completion(Completion.success([]))
        }
    }

    func hasQuotations(inContext context: NSManagedObjectContext,
                       forCurrency currency: String, inWallet wallet: WalletEntity? = nil) throws -> Bool {
        let currencyPredicate: NSPredicate = NSPredicate(format: "currency.acronym = %@", currency)

        var subPredicates: [NSPredicate] =  [currencyPredicate]

        if let wallet: WalletEntity = wallet {
            let walletPredicate: NSPredicate = NSPredicate(format: "currency.wallet = %@", wallet)
            subPredicates.append(walletPredicate)
        }

        let fetchRequest: NSFetchRequest<QuotationEntity> = NSFetchRequest(entityName: "QuotationEntity")
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: subPredicates)

        return try !context.fetch(fetchRequest).isEmpty
    }
}
