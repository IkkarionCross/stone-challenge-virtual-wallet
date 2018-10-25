//
//  CurrencyTypeTextFieldDelegate.swift
//  virtualwallet
//
//  Created by victor-mac on 13/09/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class CurrencyTypeTextFieldDelegate: NSObject {
    private(set) var activeTextField: UITextField?
    private var viewModel: TransactionViewModel
    private var inputView: UIPickerView

    init(viewModel: TransactionViewModel, inputView: UIPickerView) {
        self.viewModel = viewModel
        self.inputView = inputView
    }
}

extension CurrencyTypeTextFieldDelegate: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var selectedRow: Int = 0
        if textField.tag == TransactionViewController.FieldTag.currencyType.rawValue {
            selectedRow = viewModel.buyCurrencySelectedIndex
        } else {
            selectedRow = viewModel.exchangeCurrencySelectedIndex
        }
        self.activeTextField = textField
        self.inputView.selectRow(selectedRow, inComponent: 0, animated: true)
        self.inputView.delegate?.pickerView?(inputView, didSelectRow: selectedRow, inComponent: 0)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        inputView.resignFirstResponder()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
}
