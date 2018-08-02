
//
//  TransactionInteractor.swift
//  virtualwallet
//
//  Created by victor-mac on 13/06/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class TransactionController: NSObject {
    var view: TransactionView

    private var viewModel: TransactionViewModel {
        return view.viewModel
    }
    private var activeTextField: UITextField? {
        get {
            return view.activeTextField
        }
        set {
            view.activeTextField = newValue
        }
    }
    private var currencyTypePicker: UIPickerView {
        return view.currencyTypePicker
    }

    init(transactionView: TransactionView) {
        self.view = transactionView
        super.init()
    }

    func transactionTypeChanged(newIndex: Int) throws {
        guard let newTransactiontype = TransactionType(rawValue: newIndex) else {
            throw TransactionError.unrecognezedTransactiontype
        }
        self.viewModel.transactionType = newTransactiontype
    }
}

extension TransactionController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var selectedRow: Int = 0
        if textField.tag == TransactionViewController.FieldTag.currencyType.rawValue {
            selectedRow = viewModel.buyCurrencySelectedIndex
        } else {
            selectedRow = viewModel.exchangeCurrencySelectedIndex
        }
        self.activeTextField = textField
        self.currencyTypePicker.selectRow(selectedRow, inComponent: 0, animated: true)
        self.pickerView(currencyTypePicker, didSelectRow: selectedRow, inComponent: 0)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
}

extension TransactionController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currencyType: String = viewModel.acceptedCurrency(forRow: row) else {
            fatalError("Transaction Currency type not loaded correctly!")
        }
        guard let activeTextField: UITextField = self.activeTextField else {
            fatalError("ActiveTextField not set correctly!")
        }
        activeTextField.text = currencyType
        if activeTextField.tag == TransactionViewController.FieldTag.currencyType.rawValue {
            viewModel.buyCurrency = currencyType
        } else {
            viewModel.exchangeForCurrency = currencyType
        }
    }
}

extension TransactionController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.acceptedCurrenciesCount
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let currencyType: String = viewModel.acceptedCurrency(forRow: row) else {
            fatalError("Transaction Currency type not loaded correctly!")
        }
        return currencyType
    }
}

extension TransactionController: TransactionDelegate {
    func didTransactionTypeChanged() {
        self.view.buyCurrencyLabel.text = self.viewModel.buyCurrencyDescription
    }

    func didExchangeCurrencyTypeChanged() {
        self.view.setupAmountTextField(withCurrencySymbol: viewModel.exchangeForCurrency)
    }

    func didBuyCurrencyTypeChanged() {
        self.view.amountTextField.text = viewModel.exchangeAmount
    }
}
