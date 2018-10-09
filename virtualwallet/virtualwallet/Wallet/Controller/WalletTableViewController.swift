//
//  WalletTableViewController.swift
//  virtualwallet
//
//  Created by victor-mac on 16/04/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit
/*
 Show the current ammount for each currency
 */
class WalletTableViewController: UITableViewController {
    private let cellIdentifier: String = "currency"
    private var viewModel: WalletViewModel
    var dataContainer: DataContainer?

    init(viewModel: WalletViewModel, dataContainer: DataContainer) {
        self.dataContainer = dataContainer
        self.viewModel = viewModel
        super.init(style: UITableView.Style.plain)
        self.tableView.allowsSelection = false
        self.modalPresentationStyle = .formSheet
        setupNavigationBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNavigationBar() {
        self.title = "Carteira"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                                 target: self, action: #selector(addTransaction))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @objc func addTransaction() {
        guard let dataContainer = self.dataContainer else {
            return // an error should be displayed here
        }
        let viewModel: TransactionViewModel = TransactionViewModel(saveTransactionsInWallet: self.viewModel.wallet,
                                                                   dataContainer: dataContainer)
        let transactionViewController: UIViewController = TransactionViewController.instantianteViewController(
            viewModel: viewModel)
        self.present(transactionViewController, animated: true, completion: {
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currenciesCount
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currencyCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if currencyCell == nil {
            currencyCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        guard let money: WalletViewModel.CurrencyViewModel =
            viewModel.currency(forIndexPath: indexPath) else {
            fatalError("Wallet invalid state there is a missing currency!")
        }
        guard let cell = currencyCell else {
            fatalError("Invalid cell! It was not created or recovered")
        }
        cell.textLabel?.text = money.name
        cell.detailTextLabel?.text = money.amount

        return cell
    }
}

extension WalletTableViewController: Persistable {}
