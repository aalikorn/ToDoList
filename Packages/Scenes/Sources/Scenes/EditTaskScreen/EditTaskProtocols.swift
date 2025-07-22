//
//  EditTaskProtocols.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

protocol EditTaskBusinessLogic: AnyObject {
    func request(_ request: EditTask.Fetch.Request)
    func request(_ request: EditTask.Back.Request)
}

protocol EditTaskRoutingLogic: AnyObject {
    func back()
}

protocol EditTaskPresentingLogic: AnyObject {
    func present(_ response: EditTask.Fetch.Response)
    func present(_ response: EditTask.Back.Response)
}

protocol EditTasktDisplayLogic: AnyObject {
    func display(_ viewModel: EditTask.Fetch.ViewModel)
    func display(_ viewModel: EditTask.Back.ViewModel)
}
