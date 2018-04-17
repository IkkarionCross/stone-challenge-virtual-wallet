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
        let viewModel = WalletViewModel(wallet: Wallet(currencies: []))
        self.walletViewController =
            WalletTableViewController(viewModel: viewModel,
            style: UITableViewStyle.plain)
        
        self.present(walletViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
