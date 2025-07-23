//
//  Database.swift
//  Core
//
//  Created by Даша Николаева on 22.07.2025.
//

import Foundation
import CoreData
import CommonModels

@MainActor
open class Database {
    private let coreData = CoreDataStack.shared
    public static var shared = Database()
    private init() { }
    
    // MARK: - CRUD Operations
    
    open func addTask(_ task: Task) {
        let backgroundContext = coreData.backgroundContext
        backgroundContext.performAndWait {
            let entity = TaskEntity(context: backgroundContext)
            entity.id = Int64(task.id)
            entity.title = task.title
            entity.todo = task.todo
            entity.completed = task.completed
            entity.date = task.date
            
            do {
                try backgroundContext.save()
            } catch {
                print("Failed to save task in background context: \(error)")
            }
        }
    }
    
    open func addTasks(_ tasks: [Task]) {
        let backgroundContext = coreData.backgroundContext
        backgroundContext.performAndWait {
            for task in tasks {
                let entity = TaskEntity(context: backgroundContext)
                entity.id = Int64(task.id)
                entity.title = task.title
                entity.todo = task.todo
                entity.completed = task.completed
                entity.date = task.date
            }
            
            do {
                try backgroundContext.save()
            } catch {
                print("Failed to batch save tasks in background context: \(error)")
            }
        }
    }
    
    open func fetchAllTasks() -> [Task] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let result = try coreData.context.fetch(request)
            return result.map { entity in
                Task(
                    title: entity.title ?? "",
                    id: Int(entity.id),
                    todo: entity.todo ?? "",
                    completed: entity.completed,
                    date: entity.date ?? Date()
                )
            }
        } catch {
            print("Error fetching tasks: \(error)")
            return []
        }
    }
    
    open func fetchTask(byId id: Int) -> Task? {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        
        do {
            guard let entity = try coreData.context.fetch(request).first,
                  let title = entity.title,
                  let todo = entity.todo,
                  let date = entity.date else {
                return nil
            }
            
            return Task(
                title: title,
                id: Int(entity.id),
                todo: todo,
                completed: entity.completed,
                date: date
            )
        } catch {
            print("Error fetching task by ID: \(error)")
            return nil
        }
    }
    
    open func updateTask(_ task: Task) {
        let backgroundContext = coreData.backgroundContext
        backgroundContext.performAndWait {
            let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", task.id)
            request.fetchLimit = 1
            
            do {
                if let entity = try backgroundContext.fetch(request).first {
                    entity.title = task.title
                    entity.todo = task.todo
                    entity.completed = task.completed
                    entity.date = task.date
                    
                    try backgroundContext.save()
                }
            } catch {
                print("Error updating task in background context: \(error)")
            }
        }
    }
    
    open func deleteTask(withId id: Int) {
        let backgroundContext = coreData.backgroundContext
        backgroundContext.performAndWait {
            let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            request.fetchLimit = 1
            
            do {
                if let entity = try backgroundContext.fetch(request).first {
                    backgroundContext.delete(entity)
                    try backgroundContext.save()
                }
            } catch {
                print("Error deleting task in background context: \(error)")
            }
        }
    }
    
    open func toggleTaskCompletion(id: Int) {
        let backgroundContext = coreData.backgroundContext
        backgroundContext.performAndWait {
            let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            request.fetchLimit = 1
            
            do {
                if let entity = try backgroundContext.fetch(request).first {
                    entity.completed.toggle()
                    try backgroundContext.save()
                }
            } catch {
                print("Error toggling task completion in background context: \(error)")
            }
        }
    }
}
