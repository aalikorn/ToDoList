//
//  EditTaskView.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import CommonUI

final class EditTaskView: View {
    enum Action {
        case back
        case save(String, String)
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    var viewModel: EditTask.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
        }
    }
}
