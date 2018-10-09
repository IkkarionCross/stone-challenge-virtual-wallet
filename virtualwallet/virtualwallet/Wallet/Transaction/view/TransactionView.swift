//
//  TransactionView.swift
//  virtualwallet
//
//  Created by victor-mac on 23/07/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

protocol TransactionView: class {
    var currencyTypePicker: UIPickerView {get}
    var activeTextField: UITextField? {get set}
    var viewModel: TransactionViewModel {get}
    var buyCurrencyLabel: UILabel! {get set}
    var amountTextField: UITextField! {get set}
    var totalValueTextField: UITextField! {get set}

    func setupAmountTextField(withDelegate delegate: CurrencyAmmountDelegate?)
}

extension TransactionView where Self: TransactionDelegate, Self: UIViewController {
    func didTransactionTypeChanged() {
        self.buyCurrencyLabel.text = self.viewModel.buyCurrencyDescription
    }

    func didBuyCurrencyTypeChanged() {
        self.amountTextField.text = viewModel.exchangeAmount
    }

    func didExchangeAmountChanged() {
        do {
            self.totalValueTextField.text = try viewModel.totalValue()
        } catch {
            if let appError = error as? AppError {
                self.show(appError: appError)
            } else {
                self.show(appError: TransactionError.canNotCalculateTotalValue)
            }
        }
    }
}
