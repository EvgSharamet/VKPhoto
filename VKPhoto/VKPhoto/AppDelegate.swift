//
//  AppDelegate.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import UIKit
import CoreData

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainNavigationController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
