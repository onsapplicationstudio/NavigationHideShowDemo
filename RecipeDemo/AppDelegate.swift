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
        //window's root object
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootVC = UINavigationController(rootViewController: RecipeDetailPageVC.instantiate())
        window?.rootViewController = rootVC
        
        return true
    }

    

}

