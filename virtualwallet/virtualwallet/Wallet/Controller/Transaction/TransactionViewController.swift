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
    private var viewModel: TransactionViewModel
    private var interactor: TransactionInteractor

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.currencyTypePicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        self.viewModel = TransactionViewModel()
        self.interactor = TransactionInteractor(viewModel: viewModel, currencyTypePicker: currencyTypePicker)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.currencyTypePicker.delegate = interactor
        self.currencyTypePicker.dataSource = interactor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        setupCurrencyTextFields()
        setupAmountTextField(withCurrencySymbol: viewModel.exchangeForCurrency)
        setupNavigationBar()
    }

    func setupInputView(forTextField textField: UITextField) {
        textField.inputView = currencyTypePicker
        textField.delegate = interactor
    }

    func setupCurrencyTextFields() {
        setupInputView(forTextField: currencyTypeTextField)
        setupInputView(forTextField: exchangeTypeTextField)
        self.currencyTypeTextField.tag = FieldTag.currencyType.rawValue
        self.exchangeTypeTextField.tag = FieldTag.exchangeType.rawValue

        self.currencyTypeTextField.text = viewModel.buyCurrency
        self.exchangeTypeTextField.text = viewModel.exchangeForCurrency
    }

    func setupAmountTextField(withCurrencySymbol symbol: String) {
        self.currencyDelegate = CurrencyFieldDelegate(currencySymbol: symbol)
        self.amountTextField.delegate = self.currencyDelegate
        self.amountTextField.text = viewModel.exchangeAmount
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
        self.interactor.dismiss(viewController: self)
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

extension TransactionViewController: TransactionDelegate {
    func didExchangeCurrencyTypeChanged() {
        self.setupAmountTextField(withCurrencySymbol: viewModel.exchangeForCurrency)
    }

    func didBuyCurrencyTypeChanged() {
        self.amountTextField.text = viewModel.exchangeAmount
    }
}
