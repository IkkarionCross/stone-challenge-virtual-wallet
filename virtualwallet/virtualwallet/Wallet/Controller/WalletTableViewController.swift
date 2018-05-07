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

    private var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(style: UITableViewStyle.plain)
        self.tableView.allowsSelection = false
        setupNavigationBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNavigationBar() {
        self.title = "Carteira"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,
                                                                 target: self, action: #selector(addTransaction))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @objc func addTransaction() {
        print("transaction created!") // call transaction viewController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows(forSection: section)
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currencyCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if currencyCell == nil {
            currencyCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        guard let money: AccumulatableMoney =
            viewModel.money(forIndexPath: indexPath) as? AccumulatableMoney else {
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
