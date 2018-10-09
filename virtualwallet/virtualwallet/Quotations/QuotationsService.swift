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
    func lastQuotation(forCurrency currency: String) throws -> QuotationEntity?
    func fetchQuotations(fromCurrencyProvider provider: CurrencyProvider,
                         completion: @escaping (_ result: Completion<[QuotationEntity]>) -> Void)
    func hasQuotations(forCurrency currency: String, inWallet wallet: WalletEntity?) throws -> Bool
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

    func hasQuotations(forCurrency currency: String, inWallet wallet: WalletEntity? = nil) throws -> Bool {
        let context: NSManagedObjectContext = self.dataContainer.walletDataContext
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

    func lastQuotation(forCurrency currency: String) throws -> QuotationEntity? {
        let today: Date = Date()
        guard let tomorrow: NSDate = today.tomorrow() as NSDate? else { return nil }
        guard let yesterday: NSDate = today.yesterday() as NSDate? else { return nil }

        let context: NSManagedObjectContext = self.dataContainer.walletDataContext
        let currencyPredicate: NSPredicate =
            NSPredicate(format: "acronym = %@ and (timeStamp > %@ and timeStamp < %@)",
                        currency, yesterday, tomorrow)

        let fetchRequest: NSFetchRequest<QuotationEntity> = NSFetchRequest(entityName: "QuotationEntity")
        fetchRequest.predicate = currencyPredicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: true)]

        return try context.fetch(fetchRequest).first
    }
}
