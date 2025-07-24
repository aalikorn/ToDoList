//
//  UserDefaultsService.swift
//  Core
//
//  Created by Даша Николаева on 24.07.2025.
//

import Foundation

public final class UserDefaultsService {
    public static var isNotFirstLaunch: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isNotFirstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isNotFirstLaunch")
        }
    }
}
