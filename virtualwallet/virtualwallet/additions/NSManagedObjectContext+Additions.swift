//
//  NSManagedObjectContext+Additions.swift
//  virtualwallet
//
//  Created by victor-mac on 01/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func newBackgroundContext() -> NSManagedObjectContext {
        let newContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        newContext.parent = self
        return newContext
    }
}
