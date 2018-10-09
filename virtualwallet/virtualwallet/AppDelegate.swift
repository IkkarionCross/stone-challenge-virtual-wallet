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

    var service: QuotationsService?
    var window: UIWindow?
    lazy var container: WalletDataContainer = {
        return WalletDataContainer(modelName: "wallet")
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        do {
            let rootViewController =
                try WalletTableViewController(viewModel: createWalletViewModel(), dataContainer: container)
            rootViewController.dataContainer = container

            let navViewController: UINavigationController =
                UINavigationController(rootViewController: rootViewController)
            navViewController.navigationBar.backgroundColor = UIColor.white

            window?.rootViewController = navViewController
            window?.makeKeyAndVisible()
        } catch {
            fatalError("Could not initialize the application")
        }

        return true
    }

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        initializeCurrencyQuotations()
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

    func createWalletViewModel() throws -> WalletViewModel {
        let wallet: WalletEntity = try WalletEntity.currentWallet(fromContext: container.walletDataContext) ??
            InitialDataCreator.createDefaultWallet(inContainer: container)
        try container.walletDataContext.save()
        return WalletViewModel(wallet: wallet)
    }

    func initializeCurrencyQuotations() {
        service = QuotationsService(dataContainer: self.container)
        service?.fetchQuotations(fromCurrencyProvider: .centralBank) { result in
            switch result {
            case .success:
                ()
            case .failure: // if there is a failure it will be shown on the transactions screen
                () // it should log on a analytics library
            }
        }
        service?.fetchQuotations(fromCurrencyProvider: .bitcoinMarket) { result in
            switch result {
            case .success:
                ()
            case .failure: // if there is a failure it will be shown on the transactions screen
                () // it should log on a analytics library
            }
        }
    }
}
