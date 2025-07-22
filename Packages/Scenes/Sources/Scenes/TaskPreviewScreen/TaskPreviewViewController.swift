//
//  TaskPreviewViewController.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit

final class TaskPreviewViewController: UIViewController {
    var interactor: TaskPreviewBusinessLogic?
    
    private lazy var rootView = TaskPreviewView()
    override func loadView() {
        super.loadView()
        view = rootView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.request(TaskPreview.Fetch.Request())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let targetSize = CGSize(width: 320, height: UIView.layoutFittingCompressedSize.height)

        let size = rootView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        preferredContentSize = CGSize(width: size.width, height: size.height)
    }

}

extension TaskPreviewViewController: @preconcurrency TaskPreviewDisplayLogic {
    func display(_ viewModel: TaskPreview.Fetch.ViewModel) {
        rootView.viewModel = viewModel.root
    }
}
