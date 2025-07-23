//
//  TaskListPresenterMock.swift
//  Scenes
//
//  Created by Даша Николаева on 23.07.2025.
//

import Foundation
import CommonModels
import Core
@testable import Scenes

final class TaskListPresenterMock: TaskListPresentingLogic {
    var didCallPresentDelete = false
    var deleteResponse: TaskList.Delete.Response?

    func present(_ response: TaskList.Delete.Response) {
        didCallPresentDelete = true
        deleteResponse = response
    }

    func present(_ response: TaskList.Fetch.Response) {}
    func present(_ response: TaskList.Add.Response) {}
    func present(_ response: TaskList.Done.Response) {}
    func present(_ response: TaskList.Search.Response) {}
    func present(_ response: TaskList.Edit.Response) {}
}
