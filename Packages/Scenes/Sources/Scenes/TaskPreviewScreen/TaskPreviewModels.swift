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
            var model: Model?
        }
        
        struct ViewModel {
            var root: RootViewModel?
        }
    }
    
    struct Model {
        var task: Task
    }
    
    struct RootViewModel {
        var task: TaskViewModel
    }
}
