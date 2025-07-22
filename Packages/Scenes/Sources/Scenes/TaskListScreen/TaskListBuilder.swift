//
//  TaskListBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit

public final class TaskListBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = TaskListViewController()
        return vc
    }
}
