//
//  TaskPreviewBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit

public final class TaskPreviewBuilder {
    @MainActor public static func build(id: Int) -> UIViewController {
        let vc = TaskPreviewViewController()
        let presenter = TaskPreviewPresenter(view: vc)
        let interactor = TaskPreviewInteractor(id: id, presenter: presenter)
        vc.interactor = interactor
        return vc
    }
}
