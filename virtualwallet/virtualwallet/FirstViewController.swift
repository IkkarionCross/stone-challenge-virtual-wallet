//
//  FirstViewController.swift
//  virtualwallet
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class QuotationsViewController: UITableViewController {
    let operationQueue: OperationQueue = OperationQueue()
    var updateOperation: UpdateCurrencyPropertiesOperation!

    var quotations: [JSONQuotation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let currencyOnDate = Date()
        let urlRequest: CurrencyRouter = CurrencyRouter.retrieveQuotationFor(currencyAcronym: "USD",
                                                                             date: currencyOnDate)
        let service: RESTService = RESTService(request: urlRequest,
                                                               queue: DispatchQueue.global())
        updateOperation = UpdateCurrencyPropertiesOperation(service: service)

        updateOperation.operationDidFinish = { error, info in
            DispatchQueue.main.async {
                if let quotations: [JSONQuotation] = info?["quotations"] as? [JSONQuotation] {
                    self.quotations = quotations
                }
                self.tableView.reloadData()
            }
        }

        operationQueue.addOperation(updateOperation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quotation = quotations[indexPath.row]

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
