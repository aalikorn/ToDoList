//
//  TaskPreviewPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import CommonModels
import Foundation

final class TaskPreviewPresenter {
    let view: TaskPreviewDisplayLogic?
    
    init(view: TaskPreviewDisplayLogic) {
        self.view = view
    }
}

extension TaskPreviewPresenter: TaskPreviewPresentingLogic {
    func present(_ response: TaskPreview.Fetch.Response) {
        guard let task = response.model?.task else { return }
        view?.display(TaskPreview.Fetch.ViewModel(root: .init(task: TaskViewModel(
            title: task.title.isEmpty ? task.todo : task.title,
            id: task.id,
            todo: task.todo,
            completed: task.completed,
            date: formattedDate(task.date)
        ))))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}
