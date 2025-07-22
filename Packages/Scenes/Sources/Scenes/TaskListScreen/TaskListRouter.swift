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

extension TaskListRouter: TaskListRoutingLogic {
    func preview(taskId: Int) {
        
    }
    
    func add() {
        
    }
    
    func edit(taskId: Int) {
        
    }
}
