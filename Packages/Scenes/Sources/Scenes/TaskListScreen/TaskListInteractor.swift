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
        let request = TaskRequest()
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let response):
                let mappedResponse = response.map { item in
                    Task(title: "", id: item.id, todo: item.todo, completed: item.completed, date: Date())
                }
                Database.shared.addTasks(mappedResponse)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.presenter.present(TaskList.Fetch.Response(
                        model: .init(items: mappedResponse, total: mappedResponse.count)
                    ))
                }
                
            case .failure(let error):
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
        presenter.present(TaskList.Preview.Response())
    }
    
    func request(_ request: TaskList.Done.Request) {
        presenter.present(TaskList.Done.Response())
    }
    
    func request(_ request: TaskList.Search.Request) {
        let filtered = tasks.filter {
            $0.title.localizedCaseInsensitiveContains(request.query) || $0.todo.localizedCaseInsensitiveContains(request.query)
        }
        presenter.present(TaskList.Search.Response(model: .init(items: filtered, total: filtered.count)))
    }
    
    func request(_ request: TaskList.Edit.Request) {
        presenter.present(TaskList.Edit.Response())
    }
}
