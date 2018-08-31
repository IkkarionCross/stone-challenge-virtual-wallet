//
//  WalletEntity+CoreDataClass.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WalletEntity)
public class WalletEntity: NSManagedObject {

    static func currentWallet(fromContext context: NSManagedObjectContext) throws -> WalletEntity? {
        let fetchRequest: NSFetchRequest<WalletEntity> = NSFetchRequest(entityName: "WalletEntity")
        return try context.fetch(fetchRequest).first
    }
}
