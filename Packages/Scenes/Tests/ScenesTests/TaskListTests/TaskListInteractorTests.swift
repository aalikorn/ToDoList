//
//  TaskListInteractorTests.swift
//  Scenes
//
//  Created by Даша Николаева on 23.07.2025.
//

import XCTest
import CommonModels
import Core
@testable import Scenes

final class TaskListInteractorTests: XCTestCase {
    @MainActor
    func testDeleteTask_shouldCallPresenterWithCorrectResponse() async {
        let presenterMock = TaskListPresenterMock()
        let interactor = TaskListInteractor(presenter: presenterMock)

        let task = Task(title: "", id: -10, todo: "", completed: false, date: Date())
        interactor.tasks = [task]
        Database.shared.addTask(task)

        interactor.request(TaskList.Delete.Request(id: -10))

        let exp = expectation(description: "Presenter called")
        DispatchQueue.main.async {
            exp.fulfill()
        }

        await fulfillment(of: [exp], timeout: 1)

        XCTAssertTrue(presenterMock.didCallPresentDelete)
        XCTAssertEqual(presenterMock.deleteResponse?.model?.id, task.id)
        XCTAssertFalse(interactor.tasks.contains(where: { $0.id == -10 }))
        
        if Database.shared.fetchTask(byId: -10) != nil {
            Database.shared.deleteTask(withId: -10)
        }
    }
}


