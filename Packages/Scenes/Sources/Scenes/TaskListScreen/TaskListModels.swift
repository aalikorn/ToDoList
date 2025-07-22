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
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Preview {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
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
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Search {
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
    
    struct Model {
        let items: [Task]
        let total: Int
    }
    
    struct RootViewModel {
        let items: [Task]
        let total: Int
    }
}
