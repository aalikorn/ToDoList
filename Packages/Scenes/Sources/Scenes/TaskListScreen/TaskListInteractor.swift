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
    @MainActor func request(_ request: TaskList.Fetch.Request) {
        tasks = Database.shared.fetchAllTasks()
        guard tasks.isEmpty else {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.presenter.present(TaskList.Fetch.Response(
                    model: .init(items: self.tasks, total: self.tasks.count)
                ))
            }
            return
        }
        print(tasks)
        let request = TaskRequest()
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let initResponse):
                let response = initResponse.todos
                let mappedResponse = response.map { item in
                    Task(title: "", id: item.id, todo: item.todo, completed: item.completed, date: Date())
                }
                print(mappedResponse)
                Database.shared.addTasks(mappedResponse)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.presenter.present(TaskList.Fetch.Response(
                        model: .init(items: mappedResponse, total: mappedResponse.count)
                    ))
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.presenter.present(TaskList.Fetch.Response(
                        error: error
                    ))
                }
            }
        }
    }
    
    func request(_ request: TaskList.Add.Request) {
        presenter.present(TaskList.Add.Response())
    }
    
    func request(_ request: TaskList.Preview.Request) {
        presenter.present(TaskList.Preview.Response(id: request.id))
    }
    
    @MainActor func request(_ request: TaskList.Done.Request) {
        let id = request.id
        guard let taskIndex = tasks.firstIndex(where: { $0.id == id }) else {
            return
        }
        Database.shared.toggleTaskCompletion(id: id)
        tasks[taskIndex].completed.toggle()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.presenter.present(TaskList.Done.Response(model: .init(items: tasks, total: tasks.count)))
        }
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
