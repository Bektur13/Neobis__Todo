//
//  ViewController.swift
//  TodoApp
//
//  Created by Бектур Дуйшембеков on 1/30/24.
//

import UIKit

class TodoAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    var tableView = UITableView()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = " ToDo App"
        label.tintColor = UIColor.black
        return label
    }()
    
    lazy var secondView: UIViewController = {
        let addPage = UIViewController()
        return addPage
    }()
    
    lazy var table: UITableView = {
        let table = UITableView()
//        table.register(TaskCell.self, forCellReuseIdentifier: "CellIdentifier")
        table.tableHeaderView = UIView()
        table.dataSource = self
        table.delegate = self
        table.sectionFooterHeight = 100
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor.green
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        button.tintColor = UIColor.blue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    // SecondPage
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    lazy var inputTask: UITextField = {
        let task = UITextField()
        task.placeholder = "Add Task"
        task.layer.cornerRadius = 8
        task.layer.borderWidth = 0.5
        task.layer.borderColor = UIColor.gray.cgColor
        return task
    }()
    
    lazy var inputDescription: UITextView = {
        let description = UITextView()
        description.layer.cornerRadius = 8
        description.layer.borderColor = UIColor.gray.cgColor
        description.layer.borderWidth = 0.5
        return description
    }()
    
    lazy var deleteButton: UIButton = {
        let delete = UIButton()
        delete.setTitle("Delete", for: .normal)
        delete.setTitleColor( .red, for: .normal)
        return delete
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        secondView.view.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    @objc func didTapButton(sender: UIButton) {
        self.present(secondView, animated: true, completion: nil)
    }
    
    @objc func didTapCancelButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpConstraints() {
        // MAIN PAGE
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(30)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
                                     
                                     addButton.heightAnchor.constraint(equalToConstant: 50),
                                     addButton.widthAnchor.constraint(equalToConstant: 50),
                                    ])
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             editButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
             editButton.heightAnchor.constraint(equalToConstant: 50),
             editButton.widthAnchor.constraint(equalToConstant: 50)])
        
        // SECOND PAGE
        secondView.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: secondView.view.topAnchor, constant: 50),
            cancelButton.leadingAnchor.constraint(equalTo: secondView.view.leadingAnchor, constant: 20)
        ])
        
        secondView.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: secondView.view.topAnchor, constant: 50),
            saveButton.trailingAnchor.constraint(equalTo: secondView.view.trailingAnchor, constant: -20)
        ])
        
        secondView.view.addSubview(inputTask)
        inputTask.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTask.topAnchor.constraint(equalTo: secondView.view.topAnchor, constant: 150),
            inputTask.leadingAnchor.constraint(equalTo: secondView.view.leadingAnchor, constant: 20),
            inputTask.trailingAnchor.constraint(equalTo: secondView.view.trailingAnchor, constant: -20),
            inputTask.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        secondView.view.addSubview(inputDescription)
        inputDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputDescription.topAnchor.constraint(equalTo: secondView.view.topAnchor, constant: 220),
            inputDescription.bottomAnchor.constraint(equalTo: secondView.view.bottomAnchor, constant: -100),
            inputDescription.trailingAnchor.constraint(equalTo: secondView.view.trailingAnchor, constant: -20),
            inputDescription.leadingAnchor.constraint(equalTo: secondView.view.leadingAnchor, constant: 20)
        ])
        
        secondView.view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: secondView.view.bottomAnchor, constant: -50),
            deleteButton.centerXAnchor.constraint(equalTo: secondView.view.centerXAnchor)
        ])
    }
    
}
