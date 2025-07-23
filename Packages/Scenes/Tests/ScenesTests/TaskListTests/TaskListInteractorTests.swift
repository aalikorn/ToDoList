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
    var presenterMock: TaskListPresenterMock!
    var interactor: TaskListInteractor!

    @MainActor override func setUp() async throws {
        presenterMock = TaskListPresenterMock()
        interactor = TaskListInteractor(presenter: presenterMock)
        interactor.tasks = []
    }

    // MARK: - Delete

    @MainActor
    func testDeleteTask_shouldCallPresenterWithCorrectResponse() {
        let task = Task(title: "Title", id: -10, todo: "Todo", completed: false, date: Date())
        interactor.tasks = [task]
        Database.shared.addTask(task)
        
        interactor.request(TaskList.Delete.Request(id: -10))

        XCTAssertTrue(presenterMock.didCallPresentDelete)
        XCTAssertEqual(presenterMock.deleteResponse?.model?.id, task.id)
        XCTAssertFalse(interactor.tasks.contains(where: { $0.id == -10 }))

        if Database.shared.fetchTask(byId: -10) != nil {
            Database.shared.deleteTask(withId: -10)
        }
    }

    // MARK: - Fetch

    @MainActor func testFetch_whenDatabaseHasTasks_shouldPresentTasksImmediately() {
        let task1 = Task(title: "T1", id: 1, todo: "todo1", completed: false, date: Date())
        let task2 = Task(title: "T2", id: 2, todo: "todo2", completed: true, date: Date())
        Database.shared.addTasks([task1, task2])
        interactor.tasks = [task1, task2]

        interactor.request(TaskList.Fetch.Request())

        XCTAssertEqual(presenterMock.fetchResponse?.model?.items.count, 2)
        XCTAssertEqual(presenterMock.fetchResponse?.model?.total, 2)

        Database.shared.deleteTask(withId: 1)
        Database.shared.deleteTask(withId: 2)
    }

    // MARK: - Add

    func testAdd_shouldCallPresenter() {
        interactor.request(TaskList.Add.Request())
        XCTAssertTrue(presenterMock.didCallPresentAdd)
    }

    // MARK: - Done

    @MainActor
    func testDone_shouldToggleTaskCompletion() {
        let task = Task(title: "Title", id: 99, todo: "todo", completed: false, date: Date())
        Database.shared.addTask(task)
        interactor.tasks = [task]

        interactor.request(TaskList.Done.Request(id: 99))

        XCTAssertTrue(interactor.tasks[0].completed)

        Database.shared.deleteTask(withId: 99)
    }

    // MARK: - Search

    func testSearch_emptyQuery_returnsAllTasks() {
        let task = Task(title: "Test", id: 10, todo: "todo", completed: false, date: Date())
        interactor.tasks = [task]

        interactor.request(TaskList.Search.Request(query: ""))

        XCTAssertEqual(presenterMock.searchResponse?.model?.items.count, 1)
        XCTAssertEqual(presenterMock.searchResponse?.model?.total, 1)
    }

    func testSearch_nonEmptyQuery_filtersTasks() {
        let task1 = Task(title: "apple", id: 1, todo: "eat", completed: false, date: Date())
        let task2 = Task(title: "banana", id: 2, todo: "buy", completed: false, date: Date())
        interactor.tasks = [task1, task2]

        interactor.request(TaskList.Search.Request(query: "app"))

        XCTAssertEqual(presenterMock.searchResponse?.model?.items.count, 1)
        XCTAssertEqual(presenterMock.searchResponse?.model?.items.first?.title, "apple")
    }

    // MARK: - Edit

    func testEdit_shouldCallPresenterWithCorrectId() {
        interactor.request(TaskList.Edit.Request(id: 123))
        XCTAssertEqual(presenterMock.editResponse?.id, 123)
    }
}

