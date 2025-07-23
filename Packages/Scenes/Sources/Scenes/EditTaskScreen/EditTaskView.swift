//
//  EditTaskView.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import CommonUI

final class EditTaskView: View, UITextViewDelegate {
    enum Action {
        case back
        case save(String, String)
    }

    var actionHandler: (Action) -> Void = { _ in }

    var viewModel: EditTask.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleField.text = viewModel.task.title
            dateLabel.text = viewModel.task.date
            todoTextView.text = viewModel.task.todo
        }
    }

    // MARK: - UI

    private let backButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Назад"
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        config.image = UIImage(systemName: "chevron.left", withConfiguration: imageConfig)
        config.baseForegroundColor = .systemYellow
        config.imagePadding = 4
        config.contentInsets = .zero

        let button = UIButton(configuration: config)
        button.titleLabel?.font = .size17Regular
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()



    private let titleField: UITextField = {
        let textField = UITextField()
        textField.font = .size34Bold
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: "Название задачи",
            attributes: [.foregroundColor: UIColor.systemGray2]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .size12Regular
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let todoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .size16Regular
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    // MARK: - Setup

    override func setupContent() {
        backgroundColor = .black

        titleField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        todoTextView.delegate = self
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        addSubview(backButton)
        addSubview(titleField)
        addSubview(dateLabel)
        addSubview(todoTextView)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            titleField.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleField.heightAnchor.constraint(equalToConstant: 32),

            dateLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            todoTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            todoTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            todoTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            todoTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func backTapped() {
        actionHandler(.back)
    }

    @objc private func textDidChange() {
        actionHandler(.save(titleField.text ?? "", todoTextView.text ?? ""))
    }

    func textViewDidChange(_ textView: UITextView) {
        actionHandler(.save(titleField.text ?? "", todoTextView.text ?? ""))
    }
}
