//
//  TaskPreviewModels.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import CommonModels

enum TaskPreview {
    enum Fetch {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Edit {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Сlose {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Share {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Delete {
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
}
