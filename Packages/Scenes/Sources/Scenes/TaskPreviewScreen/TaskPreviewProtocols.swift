//
//  TaskPreviewProtocols.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

protocol TaskPreviewBusinessLogic: AnyObject {
    func request(_ request: TaskPreview.Fetch.Request)
    func request(_ request: TaskPreview.Edit.Request)
    func request(_ request: TaskPreview.Сlose.Request)
    func request(_ request: TaskPreview.Share.Request)
    func request(_ request: TaskPreview.Delete.Request)
}


protocol TaskPreviewRoutingLogic: AnyObject {
    func edit(taskID: Int)
    func close()
}

protocol TaskPreviewPresentingLogic: AnyObject {
    func present(_ response: TaskPreview.Fetch.Response)
    func present(_ response: TaskPreview.Edit.Response)
    func present(_ response: TaskPreview.Сlose.Response)
    func present(_ response: TaskPreview.Share.Response)
    func present(_ response: TaskPreview.Delete.Response)
}

protocol TaskPreviewDisplayLogic: AnyObject {
    func display(_ viewModel: TaskPreview.Fetch.ViewModel)
    func display(_ viewModel: TaskPreview.Edit.ViewModel)
    func display(_ viewModel: TaskPreview.Сlose.ViewModel)
    func display(_ viewModel: TaskPreview.Share.ViewModel)
    func display(_ viewModel: TaskPreview.Delete.ViewModel)
}

