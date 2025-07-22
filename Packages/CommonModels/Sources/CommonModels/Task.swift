//
//  Task.swift
//  CommonModels
//
//  Created by Даша Николаева on 22.07.2025.
//

import Foundation

public struct Task {
    public var title: String
    public var id: Int
    public var todo: String
    public var completed: Bool
    public var date: Date
    
    public init(title: String, id: Int, todo: String, completed: Bool, date: Date) {
        self.title = title
        self.id = id
        self.todo = todo
        self.completed = completed
        self.date = date
    }
}

public struct TaskViewModel: Hashable, Sendable {
    public let title: String
    public let id: Int
    public let todo: String
    public let completed: Bool
    public let date: String
    
    public init(title: String, id: Int, todo: String, completed: Bool, date: String) {
        self.title = title
        self.id = id
        self.todo = todo
        self.completed = completed
        self.date = date
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
