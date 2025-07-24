//
//  TaskListPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import CommonModels
import Foundation

final class TaskListPresenter {
    weak var view: TaskListDisplayLogic?
    init(view: TaskListDisplayLogic?) {
        self.view = view
    }
}

extension TaskListPresenter: TaskListPresentingLogic {
    func present(_ response: TaskList.Delete.Response) {
        if let task = response.model {
            let viewModel =
                TaskViewModel(
                    title: task.title.isEmpty ? task.todo : task.title,
                    id: task.id,
                    todo: task.todo,
                    completed: task.completed,
                    date: formattedDate(task.date)
                )
            view?.display(TaskList.Delete.ViewModel(task: viewModel, total: response.total))
        }
    }
    
    
    func present(_ response: TaskList.Edit.Response) {
        view?.display(TaskList.Edit.ViewModel(id: response.id))
    }
    
    func present(_ response: TaskList.Fetch.Response) {
        if let model = response.model {
            let root = presentAllTasks(model: model)
            view?.display(TaskList.Fetch.ViewModel(root: root, error: nil))
        } else if let error = response.error {
            view?.display(TaskList.Fetch.ViewModel(root: nil, error: error.appErrorLocalizedDescription()))
        }
    }
    
    func present(_ response: TaskList.Add.Response) {
        view?.display(TaskList.Add.ViewModel())
    }
    
    func present(_ response: TaskList.Done.Response) {
        if let model = response.model {
            let root = presentAllTasks(model: model)
            view?.display(TaskList.Done.ViewModel(root: root))
        }
    }
    
    func present(_ response: TaskList.Search.Response) {
        if let model = response.model {
            let root = presentAllTasks(model: model)
            view?.display(TaskList.Search.ViewModel(root: root))
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    private func presentAllTasks(model: TaskList.Model) -> TaskList.RootViewModel {
        let sortedItems = model.items.sorted { $0.date > $1.date }
        let viewModels = sortedItems.map { task in
            TaskViewModel(
                title: task.title.isEmpty ? task.todo : task.title,
                id: task.id,
                todo: task.todo.isEmpty ? task.title : task.todo,
                completed: task.completed,
                date: formattedDate(task.date)
            )
        }
        let root = TaskList.RootViewModel(items: viewModels, total: model.total)
        return root
    }
}
