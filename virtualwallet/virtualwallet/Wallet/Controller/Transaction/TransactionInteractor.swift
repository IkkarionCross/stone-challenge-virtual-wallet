//
//  TransactionInteractor.swift
//  virtualwallet
//
//  Created by victor-mac on 13/06/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class TransactionInteractor: NSObject {
    private var viewModel: TransactionViewModel
    private var activeTextField: UITextField?
    private var currencyTypePicker: UIPickerView

    init(viewModel: TransactionViewModel, currencyTypePicker: UIPickerView) {
        self.viewModel = viewModel
        self.currencyTypePicker = currencyTypePicker
    }

    func dismiss(viewController: UIViewController) {
        self.currencyTypePicker.removeFromSuperview()
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func transactionTypeChanged(newIndex: Int) throws {
        guard let newTransactiontype = TransactionType(rawValue: newIndex) else {
            throw TransactionError.unrecognezedTransactiontype
        }
        self.viewModel.transactionType = newTransactiontype
    }
}

extension TransactionInteractor: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var selectedRow: Int = 0
        if textField.tag == TransactionViewController.FieldTag.currencyType.rawValue {
            selectedRow = viewModel.buyCurrencySelectedIndex
        } else {
            selectedRow = viewModel.exchangeCurrencySelectedIndex
        }
        self.activeTextField = textField
        self.currencyTypePicker.selectRow(selectedRow, inComponent: 0, animated: true)
        self.pickerView(self.currencyTypePicker, didSelectRow: selectedRow, inComponent: 0)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
}

extension TransactionInteractor: UIPickerViewDelegate {
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

extension TransactionInteractor: UIPickerViewDataSource {
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
