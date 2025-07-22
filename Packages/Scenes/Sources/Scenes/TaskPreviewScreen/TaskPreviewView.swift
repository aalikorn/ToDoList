//
//  TaskPreviewView.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import CommonUI

class TaskPreviewView: View {
    var viewModel: TaskPreview.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.task.title
            descriptionLabel.text = viewModel.task.todo
            dateLabel.text = viewModel.task.date
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .size16Medium
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .size12Regular
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .size12Regular
        label.numberOfLines = 2
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupContent() {
        super.setupContent()
        backgroundColor = UIColor(red: 39/255, green: 39/255, blue: 41/255, alpha: 1)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
