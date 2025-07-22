//
//  TaskListView.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import CommonUI

final class TaskListView: View {
    enum Action {
        case preview(Int)
        case edit(Int)
        case search(String)
        case new
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    override func setupContent() {
        backgroundColor = .black
    }
    
    override func setupConstraints() {
        
    }
}

