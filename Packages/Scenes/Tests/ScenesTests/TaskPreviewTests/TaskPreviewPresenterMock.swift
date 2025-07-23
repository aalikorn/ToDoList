//
//  TaskPreviewPresenterMock.swift
//  Scenes
//
//  Created by Даша Николаева on 23.07.2025.
//

@testable import Scenes

final class TaskPreviewPresenterMock: TaskPreviewPresentingLogic {
    var didCallPresentFetch = false
    var fetchResponse: TaskPreview.Fetch.Response?

    func present(_ response: TaskPreview.Fetch.Response) {
        didCallPresentFetch = true
        fetchResponse = response
    }
}
