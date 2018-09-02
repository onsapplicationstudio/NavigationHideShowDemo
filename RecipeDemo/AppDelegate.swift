//
//  AppDelegate.swift
//  RecipeDemo
//
//  Created by Abhinay on 14/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 24.0)]
        //window's root object
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootVC = UINavigationController(rootViewController: AboutVC.instantiate())
        window?.rootViewController = rootVC
        
        return true
    }

    

}

