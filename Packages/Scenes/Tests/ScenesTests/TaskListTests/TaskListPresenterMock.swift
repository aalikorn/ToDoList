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

    var fetchResponse: TaskList.Fetch.Response?
    var didCallPresentAdd = false
    var doneResponse: TaskList.Done.Response?
    var searchResponse: TaskList.Search.Response?
    var editResponse: TaskList.Edit.Response?

    func present(_ response: TaskList.Delete.Response) {
        didCallPresentDelete = true
        deleteResponse = response
    }

    func present(_ response: TaskList.Fetch.Response) {
        fetchResponse = response
    }

    func present(_ response: TaskList.Add.Response) {
        didCallPresentAdd = true
    }

    func present(_ response: TaskList.Done.Response) {
        doneResponse = response
    }

    func present(_ response: TaskList.Search.Response) {
        searchResponse = response
    }

    func present(_ response: TaskList.Edit.Response) {
        editResponse = response
    }
}
