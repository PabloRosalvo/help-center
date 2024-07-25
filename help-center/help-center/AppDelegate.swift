//
//  AppDelegate.swift
//  ListRepositoryGoogle
//
//  Created by Pablo Rosalvo on 24/01/22.
//
//
//  AppDelegate.swift
//  WebmotorsTeste
//
//  Created by Pablo Rosalvo on 20/01/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: HomeCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initApplication()
        return true
    }
    
    func initApplication() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
        
        self.rootCoordinator = homeCoordinator
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

}

