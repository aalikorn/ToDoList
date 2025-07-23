//
//  EditTaskRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

final class EditTaskRouter {
    weak var vc: EditTaskViewController?
    init(vc: EditTaskViewController) {
        self.vc = vc
    }
}

extension EditTaskRouter: @preconcurrency EditTaskRoutingLogic {
    @MainActor func back() {
        vc?.navigationController?.popViewController(animated: true)
    }
}
