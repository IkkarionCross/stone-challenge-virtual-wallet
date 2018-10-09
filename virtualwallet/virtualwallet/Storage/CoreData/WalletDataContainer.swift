//
//  CoreDataInitializer.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import CoreData

final class WalletDataContainer: DataContainer {
    private(set) lazy var walletDataContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL: URL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Could not find the data model")
        }
        guard let managedObjectModel: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not load the data model")
        }
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let storeCoordinator: NSPersistentStoreCoordinator =
            NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {
            print("Core Data location: \(self.storeLocation)")
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: self.storeLocation,
                                                              options: self.storeOptions)
        } catch {
            fatalError("Could not laod the Persistent Store")
        }
        return storeCoordinator
    }()

    private var storeOptions: [AnyHashable: Any]? {
        return [NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true,
                NSPersistentStoreFileProtectionKey: FileProtectionType.complete]
    }

    private var storeLocation: URL {
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectoryURL.appendingPathComponent(storeName)
    }

    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }
}
