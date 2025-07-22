//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import Scenes

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = TaskListBuilder.build()

        window?.rootViewController = vc
        window?.makeKeyAndVisible()

        return true
    }
}

