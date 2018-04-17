//
//  FirstViewController.swift
//  virtualwallet
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class QuotationsViewController: UITableViewController {
    var quotationsViewModel: QuotationsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.quotationsViewModel = QuotationsViewModel(quotations: [])
        self.quotationsViewModel.delegate = self
        self.quotationsViewModel.updateQuotationsFromNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotationsViewModel.allQuotations().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quotation: JSONQuotation = quotationsViewModel.quotation(at: indexPath)

        let quotationCell: UITableViewCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            quotationCell = cell
        } else {
            quotationCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        }

        quotationCell.textLabel?.text = "USD"
        quotationCell.detailTextLabel?.text = quotation.buyQuotation.currencyString()
        return quotationCell
    }

}

extension QuotationsViewController: QuotationsDelegate {
    func onQuotationsUpdated(error: AppError?) {
        if let updateError = error {
            self.show(appError: updateError)
            return
        }
        self.tableView.reloadData()
    }
}