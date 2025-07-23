//
//  TaskListViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit

final class TaskListViewController: UIViewController {
    var interactor: TaskListBusinessLogic?
    var router: TaskListRoutingLogic?
    
    private lazy var rootView = TaskListView()
    
    override func loadView() {
        super.loadView()
        view = rootView
        
        rootView.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .edit(let id):
                self.interactor?.request(TaskList.Edit.Request(id: id))
            case .search(let query):
                self.interactor?.request(TaskList.Search.Request(query: query))
            case .new:
                self.interactor?.request(TaskList.Add.Request())
            case .done(let id):
                self.interactor?.request(TaskList.Done.Request(id: id))
            case .share(let task):
                let shareText = "\(task.title): \(task.todo). Создано \(task.date)"
                let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                present(activityVC, animated: true)
            case .delete(let id):
                self.interactor?.request(TaskList.Delete.Request(id: id))
            }
        }
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.request(TaskList.Fetch.Request())
    }
}

extension TaskListViewController: @preconcurrency TaskListDisplayLogic {
    func display(_ viewModel: TaskList.Delete.ViewModel) {
        rootView.viewModel = viewModel.root
    }
    
    func display(_ viewModel: TaskList.Edit.ViewModel) {
        router?.edit(taskId: viewModel.id)
    }
    
    func display(_ viewModel: TaskList.Fetch.ViewModel) {
        guard viewModel.error == nil else {
            return
        }
        rootView.viewModel = viewModel.root
    }
    
    func display(_ viewModel: TaskList.Add.ViewModel) {
        router?.add()
    }
    
    func display(_ viewModel: TaskList.Done.ViewModel) {
        rootView.viewModel = viewModel.root
    }
    
    func display(_ viewModel: TaskList.Search.ViewModel) {
        rootView.viewModel = viewModel.root
    }
}
