//
//  TaskListProtocols.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

protocol TaskListBusinessLogic: AnyObject {
    func request(_ request: TaskList.Fetch.Request)
    func request(_ request: TaskList.Add.Request)
    func request(_ request: TaskList.Preview.Request)
    func request(_ request: TaskList.Done.Request)
    func request(_ request: TaskList.Search.Request)
    func request(_ request: TaskList.Edit.Request)
    func request(_ request: TaskList.Delete.Request)
}

protocol TaskListRoutingLogic: AnyObject {
    func preview(taskId: Int)
    func add()
    func edit(taskId: Int)
}

protocol TaskListPresentingLogic: AnyObject {
    func present(_ response: TaskList.Fetch.Response)
    func present(_ response: TaskList.Add.Response)
    func present(_ response: TaskList.Preview.Response)
    func present(_ response: TaskList.Done.Response)
    func present(_ response: TaskList.Search.Response)
    func present(_ response: TaskList.Edit.Response)
    func present(_ response: TaskList.Delete.Response)
}

protocol TaskListDisplayLogic: AnyObject {
    func display(_ viewModel: TaskList.Fetch.ViewModel)
    func display(_ viewModel: TaskList.Add.ViewModel)
    func display(_ viewModel: TaskList.Preview.ViewModel)
    func display(_ viewModel: TaskList.Done.ViewModel)
    func display(_ viewModel: TaskList.Search.ViewModel)
    func display(_ viewModel: TaskList.Edit.ViewModel)
    func display(_ viewModel: TaskList.Delete.ViewModel)
}
