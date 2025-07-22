//
//  TaskListView.swift
//  Scenes
//
//  Created by Даша Николаева on 22.07.2025.
//

import UIKit
import CommonUI
import CommonModels

final class TaskListView: View {
    enum Action {
        case preview(Int)
        case edit(Int)
        case search(String)
        case new
        case done(Int)
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    var viewModel: TaskList.RootViewModel? {
        didSet {
            
        }
    }
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, TaskViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, TaskViewModel>
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .size34Bold
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Задачи"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .systemGray6
        searchBar.backgroundColor = .systemGray6
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.textColor = .label
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .size11Regular
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newTaskButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        button.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: config), for: .normal)
        button.setTitleColor(.mainYellowColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func setupContent() {
        backgroundColor = .black
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(footerView)
        footerView.addSubview(countLabel)
        footerView.addSubview(newTaskButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 83),
            
            countLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            
            newTaskButton.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            newTaskButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -25),
        ])
    }
}

