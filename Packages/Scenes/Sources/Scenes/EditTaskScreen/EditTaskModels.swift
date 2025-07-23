//
//  EditTaskModels.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import CommonModels

enum EditTask {
    enum Fetch {
        struct Request {
            
        }
        
        struct Response {
            var model: Model?
        }
        
        struct ViewModel {
            var RootViewModel: RootViewModel?
        }
    }
    
    enum Save {
        struct Request {
            var title: String
            var todo: String
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Back {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    struct Model {
        var task: Task
    }
    
    struct RootViewModel {
        var task: TaskViewModel
    }
    
    enum ToDoType {
        case new
        case edit
    }
}
