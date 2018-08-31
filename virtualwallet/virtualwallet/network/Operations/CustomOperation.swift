//
//  CustomOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

class CustomOperation: Operation {

    var title: String = ""
    var isRunning: Bool = false
    var isDone: Bool = false

    override var isExecuting: Bool {
        return isRunning
    }

    override var isFinished: Bool {
        return isDone
    }

    override func start() {
        if self.isCancelled {
            self.finish()
        } else {
            isRunning = true
            main()
        }
    }

    func finish () {
        self.willChangeValue(forKey: "isExecuting")
        isRunning = false
        self.didChangeValue(forKey: "isExecuting")

        self.willChangeValue(forKey: "isFinished")
        isDone = true
        self.didChangeValue(forKey: "isFinished")
    }
}
