//
//  AppDelegate.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootController : UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    lazy var applicationCoordinator: Coordinator = ApplicationCoordinator(router:Router(rootController: self.rootController) , coordinatorFactory: CoordinatorFactory( ), viewControllerFactory: ViewControllerFactory())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.applicationCoordinator.start()
        return true
    }
}

