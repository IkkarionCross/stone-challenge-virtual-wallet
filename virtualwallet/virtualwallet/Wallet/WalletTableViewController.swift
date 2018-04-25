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

    init(viewModel: WalletViewModel) {
        self.viewModel = viewModel
        super.init(style: UITableViewStyle.plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
            currencyCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        guard let currencyValue: WalletViewModel.CurrencyViewModel = viewModel.currency(forIndexPath: indexPath) else {
            fatalError("Wallet invalid state there is a missing currency!")
        }
        guard let cell = currencyCell else {
            fatalError("Invalid cell! It was not created or recovered")
        }
        cell.textLabel?.text = currencyValue.name
        cell.detailTextLabel?.text = currencyValue.value

        return cell
    }
}
