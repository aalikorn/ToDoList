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
            guard let viewModel = viewModel else { return }
                    
            countLabel.text = "\(viewModel.total) задач"

            var snapshot = Snapshot()
            snapshot.appendSections([0])
            snapshot.appendItems(viewModel.items, toSection: 0)
            dataSource.apply(snapshot, animatingDifferences: true)
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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.backgroundImage = UIImage()

        let textField = searchBar.searchTextField
        textField.backgroundColor = UIColor(red: 39/255, green: 39/255, blue: 41/255, alpha: 1)
        textField.textColor = .white

        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)]
        )
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
                textField.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 8),
                textField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -8)
            ])
        }

        return searchBar
    }()

    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        view.separatorStyle = .singleLine
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .clear
        view.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.separatorColor = UIColor.white.withAlphaComponent(0.1)
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            tableView: tableView
        ) { tableView, indexPath, item in
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
                cell.viewModel = .init(task: item)
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
            return UITableViewCell()
        }
        return dataSource
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 39/255, green: 39/255, blue: 41/255, alpha: 1)
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
        button.tintColor = .mainYellowColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func setupContent() {
        backgroundColor = .black
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(tableView)
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
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
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

extension TaskListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        actionHandler(.edit(item.id))
    }
}

class TaskCell: UITableViewCell {
    var viewModel: SearchCellContentView.Model? {
        get {
            content.viewModel
        }
        set {
            content.viewModel = newValue ?? .init(task: TaskViewModel(title: "", id: -1, todo: "", completed: false, date: ""))
        }
    }

    private lazy var content: SearchCellContentView = {
        let view = SearchCellContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        backgroundColor = .black
        contentView.backgroundColor = .black
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        return view
    }()
    
    var onToggleDone: (() -> Void)? {
        get { content.onToggleDone }
        set { content.onToggleDone = newValue }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
}

class SearchCellContentView: View {
    public var onToggleDone: (() -> Void)?
    
    public struct Model {
        let task: TaskViewModel
        
        public init(task: TaskViewModel) {
            self.task = task
        }
    }
    
    public var viewModel: Model = .init(task: TaskViewModel(title: "", id: -1, todo: "", completed: false, date: "")) {
        didSet {
            let isCompleted = viewModel.task.completed
            let grayColor = UIColor.systemGray2
            let whiteColor = UIColor.white

            let titleText = viewModel.task.title
            let attributedTitle: NSAttributedString
            if isCompleted {
                attributedTitle = NSAttributedString(
                    string: titleText,
                    attributes: [
                        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                        .foregroundColor: grayColor
                    ]
                )
            } else {
                attributedTitle = NSAttributedString(
                    string: titleText,
                    attributes: [
                        .strikethroughStyle: 0,
                        .foregroundColor: whiteColor
                    ]
                )
            }
            titleLabel.attributedText = attributedTitle

            descriptionLabel.text = viewModel.task.todo
            dateLabel.text = viewModel.task.date

            descriptionLabel.textColor = isCompleted ? grayColor : whiteColor
            dateLabel.textColor = isCompleted ? grayColor : whiteColor

            let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
            if isCompleted {
                doneButton.setImage(UIImage(systemName: "checkmark.circle", withConfiguration: config), for: .normal)
                doneButton.tintColor = .mainYellowColor
            } else {
                doneButton.setImage(UIImage(systemName: "circle", withConfiguration: config), for: .normal)
                doneButton.tintColor = .gray
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .size16Medium
        label.numberOfLines = 1
        label.textColor = .white
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
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func doneTapped() {
        onToggleDone?()
    }
    
    override func setupContent() {
        super.setupContent()
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(doneButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            doneButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 24),
            doneButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: doneButton.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leftAnchor.constraint(equalTo: doneButton.rightAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            dateLabel.leftAnchor.constraint(equalTo: doneButton.rightAnchor, constant: 8),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])

    }
}
