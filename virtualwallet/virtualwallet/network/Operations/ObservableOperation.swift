//
//  ObservableOperation.swift
//  virtualwallet
//
//  Created by victor-mac on 22/08/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

protocol ObservableOperation {
    associatedtype CompletionType

    var operationDidStart: ((_ title: String) -> Void)? { get set }
    var operationDidFinish: ((Completion<CompletionType>) -> Void)? { get set }
}

extension ObservableOperation where Self: CustomOperation {
    func finish(withError error: AppError) {
        self.operationDidFinish?(Completion.failure(error))
        self.finish()
    }

    func finish(withInfo info: CompletionType) {
        self.operationDidFinish?(Completion.success(info))
        self.finish()
    }
}
