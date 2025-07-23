//
//  EditTaskPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import Foundation
import CommonModels

final class EditTaskPresenter {
    weak var view: EditTasktDisplayLogic?
    init(view: EditTasktDisplayLogic) {
        self.view = view
    }
}

extension EditTaskPresenter: EditTaskPresentingLogic {
    func present(_ response: EditTask.Fetch.Response) {
        if let task = response.model?.task {
            view?.display(EditTask.Fetch.ViewModel(RootViewModel: .init(task: TaskViewModel(
                title: task.title.isEmpty ? task.todo : task.title,
                id: task.id,
                todo: task.todo,
                completed: task.completed,
                date: formattedDate(task.date)
            ))))
        }
        
    }
    
    func present(_ response: EditTask.Back.Response) {
        view?.display(EditTask.Back.ViewModel())
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}
