//
//  Task.swift
//  CommonModels
//
//  Created by Даша Николаева on 22.07.2025.
//

import Foundation

public struct Task {
    public let title: String
    public let id: Int
    public let todo: String
    public let completed: Bool
    public let date: Date
    
    public init(title: String, id: Int, todo: String, completed: Bool, date: Date) {
        self.title = title
        self.id = id
        self.todo = todo
        self.completed = completed
        self.date = date
    }
}

public struct TaskViewModel: Hashable, Sendable {
    let title: String
    let id: Int
    let todo: String
    let completed: Bool
    let date: String
}
