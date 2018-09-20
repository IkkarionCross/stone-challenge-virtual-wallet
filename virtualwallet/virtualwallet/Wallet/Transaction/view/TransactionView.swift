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

    func setupAmountTextField(withDelegate delegate: CurrencyAmmountDelegate?)
}
