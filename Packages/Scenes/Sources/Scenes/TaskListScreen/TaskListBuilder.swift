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
        let presenter = TaskListPresenter(view: vc)
        let interactor = TaskListInteractor(presenter: presenter)
        let router = TaskListRouter(vc: vc)
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
