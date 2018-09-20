//
//  TransactionInteractor.swift
//  virtualwallet
//
//  Created by victor-mac on 13/06/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class TransactionController: NSObject {
    private weak var view: TransactionView?

    private(set) var currencyTypeDelegate: CurrencyTypeTextFieldDelegate?
    private(set) var currencyFieldDelegate: CurrencyAmmountDelegate?

    private var viewModel: TransactionViewModel? {
        return view?.viewModel
    }

    private var currencyTypePicker: UIPickerView? {
        return view?.currencyTypePicker
    }

    init(transactionView: TransactionView) {
        self.view = transactionView
        self.currencyFieldDelegate =
            CurrencyAmmountDelegate(viewModel: transactionView.viewModel,
                                    currencySymbol: transactionView.viewModel.exchangeForCurrency)
        self.currencyTypeDelegate = CurrencyTypeTextFieldDelegate(viewModel: transactionView.viewModel,
                                                                  inputView: transactionView.currencyTypePicker)
        super.init()
    }

    func transactionTypeChanged(newIndex: Int) throws {
        guard let newTransactiontype = TransactionType(rawValue: newIndex) else {
            throw TransactionError.unrecognezedTransactiontype
        }
        self.viewModel?.transactionType = newTransactiontype
    }
}

extension TransactionController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currencyType: String = viewModel?.acceptedCurrency(forRow: row) else {
            fatalError("Transaction Currency type not loaded correctly!")
        }
        guard let activeTextField: UITextField = currencyTypeDelegate?.activeTextField else {
            fatalError("ActiveTextField not set correctly!")
        }
        activeTextField.text = currencyType
        if activeTextField.tag == TransactionViewController.FieldTag.currencyType.rawValue {
            viewModel?.buyCurrency = currencyType
        } else {
            viewModel?.exchangeForCurrency = currencyType
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let currencyType: String = viewModel?.acceptedCurrency(forRow: row) else {
            fatalError("Transaction Currency type not loaded correctly!")
        }
        return currencyType
    }
}

extension TransactionController: TransactionDelegate {
    func didTransactionTypeChanged() {
        self.view?.buyCurrencyLabel.text = self.viewModel?.buyCurrencyDescription
    }

    func didExchangeCurrencyTypeChanged() {
        guard let viewModel = viewModel else { return }
        self.currencyFieldDelegate = CurrencyAmmountDelegate(viewModel: viewModel,
                                                             currencySymbol: viewModel.exchangeForCurrency)
        self.view?.setupAmountTextField(withDelegate: self.currencyFieldDelegate)
    }

    func didBuyCurrencyTypeChanged() {
        self.view?.amountTextField.text = viewModel?.exchangeAmount
    }
}
