//
//  TaskListModels.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import CommonModels

enum TaskList {
    enum Fetch {
        struct Request {
            
        }
        
        struct Response {
            var model: Model?
            var error: Error?
        }
        
        struct ViewModel {
            var root: RootViewModel?
            var error: String?
        }
    }
    
    enum Preview {
        struct Request {
            var id: Int
        }
        
        struct Response {
            var id: Int
        }
        
        struct ViewModel {
            var id: Int
        }
    }
    
    enum Add {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Done {
        struct Request {
            var id: Int
        }
        
        struct Response {
            var model: Model?
        }
        
        struct ViewModel {
            var root: RootViewModel?
        }
    }
    
    enum Search {
        struct Request {
            var query: String
        }
        
        struct Response {
            var model: Model?
        }
        
        struct ViewModel {
            var root: RootViewModel?
        }
    }
    
    enum Edit {
        struct Request {
            var id: Int
        }
        
        struct Response {
            var id: Int
        }
        
        struct ViewModel {
            var id: Int
        }
    }
    
    enum Delete {
        struct Request {
            var id: Int
        }
        
        struct Response {
            var model: Model?
        }
        
        struct ViewModel {
            var root: RootViewModel?
        }
    }
    
    struct Model {
        let items: [Task]
        let total: Int
    }
    
    struct RootViewModel {
        let items: [TaskViewModel]
        let total: Int
    }
}
