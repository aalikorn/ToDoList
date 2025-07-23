//
//  EditTaskViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit

final class EditTaskViewController: UIViewController {
    var interactor: EditTaskBusinessLogic?
    var router: EditTaskRoutingLogic?
    
    private lazy var rootView = EditTaskView()
    
    override func loadView() {
        super.loadView()
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .back:
                self.interactor?.request(EditTask.Back.Request())
            case .save(let title, let todo):
                self.interactor?.request(EditTask.Save.Request(title: title, todo: todo))
            }
        }
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.request(EditTask.Fetch.Request())
    }
}

extension EditTaskViewController: @preconcurrency EditTasktDisplayLogic {
    func display(_ viewModel: EditTask.Fetch.ViewModel) {
        rootView.viewModel = viewModel.RootViewModel
    }
    
    func display(_ viewModel: EditTask.Back.ViewModel) {
        router?.back()
    }
}
