//
//  EditTaskBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit

public final class EditTaskBuilder {
    @MainActor public static func build(id: Int? = nil) -> UIViewController {
        let vc = EditTaskViewController()
        let presenter = EditTaskPresenter(view: vc)
        let interactor = EditTaskInteractor(id: id, presenter: presenter)
        let router = EditTaskRouter(vc: vc)
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
