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
        service?.fetchQuotations(fromCurrencyProvider: .bitcoinMarket) { [weak self] result in
            guard let container: DataContainer = self?.container else {
                return
            }
            switch result {
            case .success:
                do {
                    // for the sake of simplicity: added some quotations
                    let service: QuotationsService = QuotationsService(dataContainer: container)

                    let usdToBritas: QuotationEntity = QuotationEntity(context: container.walletDataContext)
                    usdToBritas.buyPrice = 1.0
                    usdToBritas.sellPrice = 1.0
                    usdToBritas.fromAcronym = SupportedCurrencies.BRITAS.rawValue
                    usdToBritas.toAcronym = SupportedCurrencies.USD.rawValue
                    usdToBritas.timeStamp = Date()
                    usdToBritas.reportType = QuotationReportType.close.rawValue

                    let btcToBRL: QuotationEntity! =
                        try service.lastQuotation(fromCurrency: SupportedCurrencies.BTC.rawValue,
                                                  toCurrency: SupportedCurrencies.BRL.rawValue)

                    let usdToBRL: QuotationEntity! =
                        try service.lastQuotation(fromCurrency: SupportedCurrencies.USD.rawValue,
                                                  toCurrency: SupportedCurrencies.BRL.rawValue)

                    let btcToUsd: QuotationEntity = QuotationEntity(context: container.walletDataContext)
                    btcToUsd.buyPrice = btcToBRL.buyPrice * usdToBRL.invertedBuyPrice
                    btcToUsd.sellPrice = btcToBRL.sellPrice * usdToBRL.invertedSellPrice
                    btcToUsd.fromAcronym = SupportedCurrencies.BTC.rawValue
                    btcToUsd.toAcronym = SupportedCurrencies.USD.rawValue
                    btcToUsd.timeStamp = Date()
                    btcToUsd.reportType = QuotationReportType.close.rawValue

                    try container.walletDataContext.save()
                } catch {}
            case .failure: // if there is a failure it will be shown on the transactions screen
                () // it should log on a analytics library
            }
        }
    }
}
