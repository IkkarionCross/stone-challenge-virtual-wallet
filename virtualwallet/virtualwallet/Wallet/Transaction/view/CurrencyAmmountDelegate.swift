//
//  CurrencyAmmountDelegate.swift
//  virtualwallet
//
//  Created by victor-mac on 17/09/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class CurrencyAmmountDelegate: CurrencyFieldDelegate {
    private var viewModel: TransactionViewModel

    init(viewModel: TransactionViewModel, currencySymbol symbol: String) {
        self.viewModel = viewModel
        super.init(currencySymbol: symbol)
    }

    override func textField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let shouldChangeCharactersInRange: Bool =
            super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        viewModel.exchangeAmount = textField.text ?? ""
        return shouldChangeCharactersInRange
    }
}
