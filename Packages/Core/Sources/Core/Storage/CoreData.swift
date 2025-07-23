//
//  CoreData.swift
//  Core
//
//  Created by Даша Николаева on 22.07.2025.
//

import Foundation
import CoreData

class CoreDataStack {
    @MainActor static let shared = CoreDataStack()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource: "TasksModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to locate Core Data model in Bundle.module")
        }

        let container = NSPersistentContainer(name: "TasksModel", managedObjectModel: model)
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data store load error: \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
