//
//  DataContainer.swift
//  virtualwallet
//
//  Created by victor-mac on 08/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import CoreData

protocol DataContainer {
    var walletDataContext: NSManagedObjectContext {get}
}

protocol Persistable {
    var dataContainer: DataContainer? {get set}
}
