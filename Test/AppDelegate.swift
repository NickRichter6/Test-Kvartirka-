//
//  AppDelegate.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: String(describing: ApartmentsListViewController.self), bundle: nil)
        let initialVC = storyboard.instantiateViewController(withIdentifier: String(describing: ApartmentsListViewController.self))
        let naviVC = UINavigationController(rootViewController: initialVC)
        
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
        
        
        return true
    }
}
