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
    
    // Create
    open func addTask(_ task: Task) {
        let entity = TaskEntity(context: coreData.context)
        entity.id = Int64(task.id)
        entity.title = task.title
        entity.todo = task.todo
        entity.completed = task.completed
        entity.date = task.date
        coreData.saveContext()
    }
    
    // Batch save multiple tasks
    open func addTasks(_ tasks: [Task]) {
        tasks.forEach { task in
            let entity = TaskEntity(context: coreData.context)
            entity.id = Int64(task.id)
            entity.title = task.title
            entity.todo = task.todo
            entity.completed = task.completed
            entity.date = task.date
        }
        
        coreData.saveContext()
    }
    
    // Read (all)
    open func fetchAllTasks() -> [Task] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let result = try coreData.context.fetch(request)
            return result.map { Task(
                title: $0.title ?? "",
                id: Int($0.id),
                todo: $0.todo ?? "",
                completed: $0.completed,
                date: $0.date ?? Date()
            )}
        } catch {
            print("Error fetching tasks: \(error)")
            return []
        }
    }
    
    // Get single task by ID
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
    
    // Update
    open func updateTask(_ task: Task) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", task.id)
        
        do {
            if let entity = try coreData.context.fetch(request).first {
                entity.title = task.title
                entity.todo = task.todo
                entity.completed = task.completed
                entity.date = task.date
                coreData.saveContext()
            }
        } catch {
            print("Error updating task: \(error)")
        }
    }
    
    // Delete
    open func deleteTask(withId id: Int) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let entity = try coreData.context.fetch(request).first {
                coreData.context.delete(entity)
                coreData.saveContext()
            }
        } catch {
            print("Error deleting task: \(error)")
        }
    }
    
    // Toggle completion status
    open func toggleTaskCompletion(id: Int) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let entity = try coreData.context.fetch(request).first {
                entity.completed.toggle()
                coreData.saveContext()
            }
        } catch {
            print("Error toggling task: \(error)")
        }
    }
}
