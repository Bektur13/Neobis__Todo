//
//  ViewController.swift
//  TodoApp
//
//  Created by Бектур Дуйшембеков on 1/30/24.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func taskCellDidToggleDone(for cell: CustomTableViewCell)
}

class TodoAppViewController: UIViewController {
    var tableView = UITableView()
    var dataManager = DataManager.shared
    var isNew: Bool = true
    var task: TaskModel?
    var index: Int?
    
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
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        table.tableHeaderView = UIView()
        table.dataSource = self
        table.delegate = self
        table.sectionFooterHeight = 100
        table.rowHeight = 50
        return table
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
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
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
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(30)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        inputTask.text = task?.title
        inputDescription.text = task?.description
        if !isNew {
            inputTask.isHidden = true
            inputDescription.isHidden = true
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @objc func saveButtonTapped() {
        if self.isNew {
            dataManager.tasks.append(TaskModel(title: inputTask.text!, description: inputDescription.text, isDone: false))
        } else {
            if let i = index {
                dataManager.tasks[i] = TaskModel(title: inputTask.text!, description: inputDescription.text, isDone: task?.isDone ?? false)
            }
        }
        dataManager.refreshData()
        dismiss(animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return DataManager.shared.dataManager.count
//    }}
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
//    return cell
//}
    


extension TodoAppViewController: UITableViewDataSource, UITableViewDelegate, TaskCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        cell.configureCell(title: dataManager.tasks[indexPath.row].title, description: dataManager.tasks[indexPath.row].description, isDone: dataManager.tasks[indexPath.row].isDone, image:  (dataManager.tasks[indexPath.row].isDone ? "checkmark.circle" : "circle"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataManager.tasks.count - 1 {
            cell.separatorInset.left = cell.bounds.size.width
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        isNew = false
//        
//        let task = TaskModel(title: dataManager.tasks[indexPath.row].title, description: dataManager.tasks[indexPath.row].description, isDone: dataManager.tasks[indexPath.row].isDone)
////        let vc = UINavigationController(rootViewController: TodoAppViewController)
////        vc.modalPresentationStyle = .fullScreen
////        present(vc, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.removeTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataManager.moveTask(from: sourceIndexPath.row, into: destinationIndexPath.row)
    }
    
//    func taskCellDidToggleDone(for cell: TaskCell) {
//        if let indexPath = tableView.indexPath(for: cell) {
//            dataManager.toggleDone(index: indexPath.row, isDone: cell.doneTask)
//            tableView.reloadRows(at: [indexPath], with: .none)
//            dataManager.refreshData()
//        }
//    }
    
    func taskCellDidToggleDone(for cell: CustomTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            dataManager.toggleDone(index: indexPath.row, isDone: cell.doneTask)
            tableView.reloadRows(at: [indexPath], with: .none)
            dataManager.refreshData()
        }
    }
}
