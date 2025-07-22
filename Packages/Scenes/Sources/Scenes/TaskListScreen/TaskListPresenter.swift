//
//  TaskListPresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

final class TaskListPresenter {
    weak var view: TaskListDisplayLogic?
    init(view: TaskListDisplayLogic?) {
        self.view = view
    }
}

extension TaskListPresenter: TaskListPresentingLogic {
    func present(_ response: TaskList.Edit.Response) {
        <#code#>
    }
    
    func present(_ response: TaskList.Fetch.Response) {
        <#code#>
    }
    
    func present(_ response: TaskList.Add.Response) {
        <#code#>
    }
    
    func present(_ response: TaskList.Preview.Response) {
        <#code#>
    }
    
    func present(_ response: TaskList.Done.Response) {
        <#code#>
    }
    
    func present(_ response: TaskList.Search.Response) {
        <#code#>
    }
}
