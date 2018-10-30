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
    @IBOutlet weak var buyCurrencyLabel: UILabel!
    @IBOutlet weak var totalValueTextField: UITextField!

    var activeTextField: UITextField?
    private var controller: TransactionController!
    private(set) var currencyTypePicker: UIPickerView
    private(set) var viewModel: TransactionViewModel

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: TransactionViewModel) {
        self.currencyTypePicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.controller = TransactionController(transactionView: self)
        self.currencyTypePicker.delegate = controller
        self.currencyTypePicker.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        setupCurrencyTextFields()
        let delegate: CurrencyAmmountDelegate? =
            controller.buildDelegate(forExchangeForCurrency: viewModel.exchangeForCurrency)
        setupAmountTextField(withDelegate: delegate)
        setupNavigationBar()
    }

    func setupInputView(forTextField textField: UITextField) {
        textField.inputView = currencyTypePicker
        textField.delegate = controller.currencyTypeDelegate
    }

    func setupCurrencyTextFields() {
        setupInputView(forTextField: currencyTypeTextField)
        setupInputView(forTextField: exchangeTypeTextField)
        self.currencyTypeTextField.tag = FieldTag.currencyType.rawValue
        self.exchangeTypeTextField.tag = FieldTag.exchangeType.rawValue

        self.currencyTypeTextField.text = viewModel.buyCurrency
        self.exchangeTypeTextField.text = viewModel.exchangeForCurrency
    }

    func setupAmountTextField(withDelegate delegate: CurrencyAmmountDelegate?) {
        self.amountTextField.delegate = delegate
        self.amountTextField.text = viewModel.exchangeAmount
    }

    func setupNavigationBar() {
        self.navigationItem.title = "Transação"
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                            target: self, action: #selector(onOkBarButtonTouch))

        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel,
                            target: self, action: #selector(onCancelBarButtonTouch))
    }

    // MARK: Bar button actions
    @objc func onOkBarButtonTouch() {
        do {
            try viewModel.doTransaction()
            self.dismiss(animated: true, completion: nil)
        } catch {
            let appError: AppError = (error as? AppError) ??
                TransactionError.unknownError(description: error.localizedDescription)
            show(appError: appError)
        }
    }

    @objc func onCancelBarButtonTouch() {
        self.currencyTypePicker.removeFromSuperview()
        dismiss(animated: true, completion: nil)
    }

    // MARK: ViewController Actions
    @IBAction func onTransactiontypeChanged(_ sender: Any) {
        do {
            try controller.transactionTypeChanged(newIndex: transactionTypeSegmented.selectedSegmentIndex)
        } catch {
            let appError: AppError = (error as? AppError) ??
                TransactionError.unknownError(description: error.localizedDescription)
            self.show(appError: appError)
        }
    }

    // MARK: Instantiate
    static func instantianteViewController(viewModel: TransactionViewModel) -> UIViewController {
        let transactionViewController: TransactionViewController =
            TransactionViewController(nibName: "TransactionViewController",
                                      bundle: Bundle.main, viewModel: viewModel)
        let navController: UINavigationController =
            UINavigationController(rootViewController: transactionViewController)
        navController.modalPresentationStyle = .formSheet
        navController.modalTransitionStyle = .coverVertical

        return navController
    }
}

extension TransactionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.acceptedCurrenciesCount
    }
}

extension TransactionViewController: TransactionView {}
extension TransactionViewController: TransactionDelegate {}
