//
//  EditTaskInteractorTests.swift
//  Scenes
//
//  Created by Даша Николаева on 23.07.2025.
//

import XCTest
import CommonModels
import Core
@testable import Scenes

final class EditTaskInteractorTests: XCTestCase {
    var presenterMock: EditTaskPresenterMock!
    var interactor: EditTaskInteractor!

    override func setUp() {
        super.setUp()
        presenterMock = EditTaskPresenterMock()
        interactor = EditTaskInteractor(presenter: presenterMock)
    }
    
    override func tearDown() {
        presenterMock = nil
        interactor = nil
        super.tearDown()
    }

    @MainActor
    func testSaveNewTask_addsTaskToDatabase() {
        let request = EditTask.Save.Request(title: "Test Title", todo: "Test Todo")

        interactor.request(request)

        let tasks = Database.shared.fetchAllTasks()
        XCTAssertEqual(tasks[0].title, "Test Title")
        XCTAssertEqual(tasks[0].todo, "Test Todo")
        if Database.shared.fetchTask(byId: -10) != nil {
            Database.shared.deleteTask(withId: -10)
        }
    }

    @MainActor
    func testSaveEmptyTitleAndTodo_withExistingId_deletesTask() {
        let task = Task(title: "Title", id: -10, todo: "Todo", completed: false, date: Date())
        Database.shared.addTask(task)
        interactor.id = -10

        let request = EditTask.Save.Request(title: " ", todo: " ")
        interactor.request(request)

        let tasks = Database.shared.fetchAllTasks()
        XCTAssertFalse(tasks.contains(where: { $0.id == -10 }))
        XCTAssertNil(interactor.id)
        if Database.shared.fetchTask(byId: -10) != nil {
            Database.shared.deleteTask(withId: -10)
        }
    }
}
