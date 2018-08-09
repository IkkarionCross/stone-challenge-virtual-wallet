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
    lazy var container: WalletDataContainer = {
        return WalletDataContainer(modelName: "wallet")
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let mainViewModel: MainViewModel = MainViewModel()
        let rootViewController = WalletTableViewController(viewModel: mainViewModel)

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
