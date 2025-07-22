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
    func present(_ response: TaskList.Edit.Response) {
        
    }
    
    func present(_ response: TaskList.Fetch.Response) {
        if let model = response.model {
            let viewModels = model.items.map { task in
                TaskViewModel(
                    title: task.title.isEmpty ? task.todo : task.title,
                    id: task.id,
                    todo: task.todo,
                    completed: task.completed,
                    date: formattedDate(task.date)
                )
            }
            let root = TaskList.RootViewModel(items: viewModels, total: model.total)
            view?.display(TaskList.Fetch.ViewModel(root: root, error: nil))
        } else if let error = response.error {
            view?.display(TaskList.Fetch.ViewModel(root: nil, error: error.localizedDescription))
        }
    }
    
    func present(_ response: TaskList.Add.Response) {
        
    }
    
    func present(_ response: TaskList.Preview.Response) {
        
    }
    
    func present(_ response: TaskList.Done.Response) {
        
    }
    
    func present(_ response: TaskList.Search.Response) {
        
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }

}
