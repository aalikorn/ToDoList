//
//  EditTaskInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import Foundation
import Core
import CommonModels

final class EditTaskInteractor {
    var id: Int?
    var date: Date?
    let presenter: EditTaskPresentingLogic
    
    init(id: Int? = nil, presenter: EditTaskPresentingLogic) {
        self.id = id
        self.presenter = presenter
    }
}

extension EditTaskInteractor: @preconcurrency EditTaskBusinessLogic {
    @MainActor func request(_ request: EditTask.Save.Request) {
        let title = request.title.trimmingCharacters(in: .whitespaces)
        let todo = request.todo.trimmingCharacters(in: .whitespaces)
        if let id {
            if title.isEmpty && todo.isEmpty {
                Database.shared.deleteTask(withId: id)
                self.id = nil
            } else {
                guard var task = Database.shared.fetchTask(byId: id) else { return }
                task.title = title
                task.todo = todo
                Database.shared.updateTask(task)
            }
        } else {
            guard !title.isEmpty || !todo.isEmpty else { return }
            let allTasks = Database.shared.fetchAllTasks()
            let newIndex = (allTasks.map { $0.id }.max() ?? 0) + 1
            let newTask = Task(title: title, id: newIndex, todo: todo, completed: false, date: self.date ?? Date())
            id = newIndex
            Database.shared.addTask(newTask)
        }
    }
    
    @MainActor func request(_ request: EditTask.Fetch.Request) {
        if let id {
            guard let task = Database.shared.fetchTask(byId: id) else { return }
            self.date = task.date
            DispatchQueue.main.async { [weak self] in
                self?.presenter.present(EditTask.Fetch.Response(model: EditTask.Model(task: task)))
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.presenter.present(EditTask.Fetch.Response())
            }
        }
    }
    
    @MainActor func request(_ request: EditTask.Back.Request) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter.present(EditTask.Back.Response())
        }
    }
}
