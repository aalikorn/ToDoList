//
//  TaskPreviewInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import Core
import Foundation

final class TaskPreviewInteractor {
    let id: Int
    let presenter: TaskPreviewPresentingLogic
    
    init(id: Int, presenter: TaskPreviewPresentingLogic) {
        self.id = id
        self.presenter = presenter
    }
}

extension TaskPreviewInteractor: @preconcurrency TaskPreviewBusinessLogic {
    @MainActor func request(_ request: TaskPreview.Fetch.Request) {
        guard let task = Database.shared.fetchTask(byId: id) else { return }
        presenter.present(TaskPreview.Fetch.Response(model: .init(task: task)))
    }
}
