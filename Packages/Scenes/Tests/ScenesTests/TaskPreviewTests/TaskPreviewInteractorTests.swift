//
//  TaskPeviewInteractorTests.swift
//  Scenes
//
//  Created by Даша Николаева on 23.07.2025.
//

import XCTest
import CommonModels
import Core
@testable import Scenes

final class TaskPreviewInteractorTests: XCTestCase {
    var presenterMock: TaskPreviewPresenterMock!
    var interactor: TaskPreviewInteractor!

    override func setUp() {
        super.setUp()
        presenterMock = TaskPreviewPresenterMock()
        interactor = TaskPreviewInteractor(id: -10, presenter: presenterMock)
    }

    override func tearDown() {
        presenterMock = nil
        interactor = nil
        super.tearDown()
    }

    @MainActor
    func testRequest_shouldCallPresenterWithCorrectTask() {
        let task = Task(title: "Test Title", id: -10, todo: "Test Todo", completed: false, date: Date())
        Database.shared.addTask(task)
        let request = TaskPreview.Fetch.Request()
        interactor.request(request)

        XCTAssertTrue(presenterMock.didCallPresentFetch)

        guard let response = presenterMock.fetchResponse else {
            XCTFail("No response passed to presenter")
            return
        }

        XCTAssertEqual(response.model?.task.id, -10)
        XCTAssertEqual(response.model?.task.title, "Test Title")
        XCTAssertEqual(response.model?.task.todo, "Test Todo")
        
        Database.shared.deleteTask(withId: -10)
    }
}
