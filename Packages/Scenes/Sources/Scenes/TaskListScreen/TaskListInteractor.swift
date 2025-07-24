//
//  TaskListInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import Core
import CommonModels
import Foundation

final class TaskListInteractor {
    let presenter: TaskListPresentingLogic
    init(presenter: TaskListPresentingLogic) {
        self.presenter = presenter
    }
    var tasks: [Task] = []
}

extension TaskListInteractor: @preconcurrency TaskListBusinessLogic {
    @MainActor func request(_ request: TaskList.Delete.Request) {
        let id = request.id
        guard let taskIndex = tasks.firstIndex(where: { $0.id == id }) else {
            return
        }
        Database.shared.deleteTask(withId: id)
        let task = tasks[taskIndex]
        tasks.remove(at: taskIndex)
        presenter.present(TaskList.Delete.Response(model: task, total: tasks.count))
    }
    
    @MainActor func request(_ request: TaskList.Fetch.Request) {
        tasks = Database.shared.fetchAllTasks()
        guard tasks.isEmpty else {
            presenter.present(TaskList.Fetch.Response(
                model: .init(items: self.tasks, total: self.tasks.count)
            ))
            return
        }
        guard !UserDefaultsService.isNotFirstLaunch else {
            presenter.present(TaskList.Fetch.Response(
                error: .noTasksFound
            ))
            return
        }
        UserDefaultsService.isNotFirstLaunch = true
        let request = TaskRequest()
        APIClient.shared.send(request) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let initResponse):
                let response = initResponse.todos
                let mappedResponse = response.map { item in
                    Task(title: "", id: item.id, todo: item.todo, completed: item.completed, date: Date())
                }
                self.tasks = mappedResponse
                Database.shared.addTasks(mappedResponse)
                presenter.present(TaskList.Fetch.Response(
                    model: .init(items: mappedResponse, total: mappedResponse.count)
                ))
                
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    print("🚨 error fetching tasks from network: \(error)")
                    self.presenter.present(TaskList.Fetch.Response(
                        error: .unknown
                    ))
                }
            }
        }
    }
    
    func request(_ request: TaskList.Add.Request) {
        presenter.present(TaskList.Add.Response())
    }
    
    @MainActor func request(_ request: TaskList.Done.Request) {
        let id = request.id
        guard let taskIndex = tasks.firstIndex(where: { $0.id == id }) else {
            return
        }
        Database.shared.toggleTaskCompletion(id: id)
        tasks[taskIndex].completed.toggle()
        presenter.present(TaskList.Done.Response(model: .init(items: tasks, total: tasks.count)))
    }
    
    func request(_ request: TaskList.Search.Request) {
        guard !request.query.isEmpty else {
            presenter.present(TaskList.Search.Response(model: .init(items: tasks, total: tasks.count)))
            return
        }
        let filtered = tasks.filter {
            $0.title.localizedCaseInsensitiveContains(request.query) || $0.todo.localizedCaseInsensitiveContains(request.query)
        }
        presenter.present(TaskList.Search.Response(model: .init(items: filtered, total: filtered.count)))
        
    }
    
    func request(_ request: TaskList.Edit.Request) {
        presenter.present(TaskList.Edit.Response(id: request.id))
    }
}
