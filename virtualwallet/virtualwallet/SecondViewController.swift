//
//  SecondViewController.swift
//  virtualwallet
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var walletViewController: WalletTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {

        let wallet: Wallet = Wallet(currencies: [Wallet.CurrencyValue(acronym: "BTC", value: 0.0, name: "Bitcoin"),
                                                 Wallet.CurrencyValue(acronym: "USD", value: 100.0, name: "Dólar"),
                                                 Wallet.CurrencyValue(acronym: "BRL", value: 2000.0, name: "Real")])

        let viewModel = WalletViewModel(wallet: wallet)
        self.walletViewController =
            WalletTableViewController(viewModel: viewModel)

        self.present(walletViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
