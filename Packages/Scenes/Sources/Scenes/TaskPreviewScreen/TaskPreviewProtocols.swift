//
//  TaskPreviewProtocols.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

protocol TaskPreviewBusinessLogic: AnyObject {
    func request(_ request: TaskPreview.Fetch.Request)
}

protocol TaskPreviewPresentingLogic: AnyObject {
    func present(_ response: TaskPreview.Fetch.Response)
}

protocol TaskPreviewDisplayLogic: AnyObject {
    func display(_ viewModel: TaskPreview.Fetch.ViewModel)
}

