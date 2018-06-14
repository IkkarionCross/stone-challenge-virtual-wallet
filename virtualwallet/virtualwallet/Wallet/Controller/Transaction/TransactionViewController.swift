//
//  TransactionViewController.swift
//  virtualwallet
//
//  Created by victor-mac on 24/04/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    enum FieldTag: Int {
        case currencyType = 0, exchangeType = 1
    }

    @IBOutlet weak var transactionTypeSegmented: UISegmentedControl!
    @IBOutlet weak var currencyTypeTextField: UITextField!
    @IBOutlet weak var exchangeTypeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!

    private var currencyDelegate: CurrencyFieldDelegate?
    private var currencyTypePicker: UIPickerView
    private var activeTextField: UITextField?
    private var viewModel: TransactionViewModel

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.currencyTypePicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        self.viewModel = TransactionViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.currencyTypePicker.delegate = self
        self.currencyTypePicker.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyTypeTextField.inputView = currencyTypePicker
        self.exchangeTypeTextField.inputView = currencyTypePicker
        self.currencyTypeTextField.delegate = self
        self.exchangeTypeTextField.delegate = self
        self.currencyTypeTextField.tag = FieldTag.currencyType.rawValue
        self.exchangeTypeTextField.tag = FieldTag.exchangeType.rawValue
        self.currencyDelegate = CurrencyFieldDelegate(currencySymbol: "BTC")
        self.amountTextField.delegate = self.currencyDelegate

        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupNavigationBar() {
        self.navigationItem.title = "Transação"
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
                            target: self, action: #selector(onOkBarButtonTouch))

        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel,
                            target: self, action: #selector(onCancelBarButtonTouch))
    }

    // MARK: Bar button actions
    @objc func onOkBarButtonTouch() {

    }

    @objc func onCancelBarButtonTouch() {
        self.currencyTypePicker.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: ViewController Actions
    @IBAction func onTransactiontypeChanged(_ sender: Any) {

    }

    // MARK: Instantiate
    static func instantianteViewController() -> UIViewController {
        let transactionViewController: TransactionViewController =
            TransactionViewController(nibName: "TransactionViewController",
                                      bundle: Bundle.main)
        let navController: UINavigationController =
            UINavigationController(rootViewController: transactionViewController)
        navController.modalPresentationStyle = .formSheet
        navController.modalTransitionStyle = .coverVertical

        return navController
    }
}

extension TransactionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var selectedRow: Int = 0
        if textField.tag == FieldTag.currencyType.rawValue {
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

extension TransactionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currencyType: String = viewModel.acceptedCurrency(forRow: row) else {
            fatalError("Transaction Currency type not loaded correctly!")
        }
        guard let activeTextField: UITextField = self.activeTextField else {
            fatalError("ActiveTextField not set correctly!")
        }
        activeTextField.text = currencyType
        if activeTextField.tag == FieldTag.currencyType.rawValue {
            viewModel.buyCurrency = currencyType
        } else {
            viewModel.exchangeForCurrency = currencyType
        }
    }
}

extension TransactionViewController: UIPickerViewDataSource {
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
