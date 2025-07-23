//
//  TaskListRouter.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

final class TaskListRouter {
    weak var vc: TaskListViewController?
    init(vc: TaskListViewController?) {
        self.vc = vc
    }
}

extension TaskListRouter: @preconcurrency TaskListRoutingLogic {
    @MainActor func add() {
        vc?.navigationController?.pushViewController(EditTaskBuilder.build(), animated: true)
    }
    
    @MainActor func edit(taskId: Int) {
        vc?.navigationController?.pushViewController(EditTaskBuilder.build(id: taskId), animated: true)
    }
}
