//
//  AppDelegate.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/06.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: HomeController())
    window?.backgroundColor = .systemBackground
    window?.makeKeyAndVisible()
    return true
  }
}

