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
    private var viewModel: WalletViewModel
    
    init(viewModel: WalletViewModel, style: UITableViewStyle) {
        self.viewModel = viewModel
        super.init(style: style)
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
        return UITableViewCell(style: .default,
                               reuseIdentifier: "")
    }
}
