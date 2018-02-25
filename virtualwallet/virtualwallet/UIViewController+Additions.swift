//
//  UIViewController+Additions.swift
//  virtualwallet
//
//  Created by victor-mac on 25/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showMessage(title: String?, message: String?, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            completion?()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func show(appError: AppError) {
        self.showMessage(title: appError.title, message: appError.localizedDescription, completion: nil)
    }
}
