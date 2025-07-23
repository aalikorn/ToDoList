//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import Scenes
import CommonUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let taskListVC = TaskListBuilder.build()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController(rootViewController: taskListVC)
        window?.makeKeyAndVisible()

        return true
    }
}


