//
//  AppDelegate.swift
//  virtualwallet
//
//  Created by victor-mac on 15/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        let wallet: Wallet = Wallet(currencies: [Wallet.CurrencyValue(acronym: "BTC", value: 0.0, name: "Bitcoin"),
                                                 Wallet.CurrencyValue(acronym: "USD", value: 100.0, name: "Dólar"),
                                                 Wallet.CurrencyValue(acronym: "BRL", value: 2000.0, name: "Real")])

        let viewModel = WalletViewModel(wallet: wallet)
        let rootViewController = WalletTableViewController(viewModel: viewModel)

        let navViewController: UINavigationController = UINavigationController(rootViewController: rootViewController)
        navViewController.navigationBar.backgroundColor = UIColor.white

        window?.rootViewController = navViewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
