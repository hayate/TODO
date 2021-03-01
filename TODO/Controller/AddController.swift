//
//  AddController.swift
//  TODO
//
//  Created by Andrea Belvedere on 2021/03/01.
//

import UIKit

class AddController: UIViewController {

    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!

    private let tasks: Task = Task.getInstance()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() -> Void {
        title = "New Task"

        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.backgroundColor = .label
        addTaskButton.tintColor = .systemGray6
        addTaskButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        addTaskButton.layer.cornerRadius = 10
        addTaskButton.sizeToFit()

        newTaskTextField.becomeFirstResponder()
        newTaskTextField.delegate = self
        newTaskTextField.placeholder = "Enter new task"
    }

    @IBAction func onAddTaskButtonTap(_ sender: Any) {
        if self.addTask() {
            self.navigateBack()
        }
    }

    private func addTask() -> Bool {
        guard let task = newTaskTextField.text, !task.isEmpty else {return false}

        tasks.addTask(todo: task)
        return true
    }

    private func navigateBack(animated: Bool = true) -> Void {
        navigationController?.popViewController(animated: animated)
    }
}

extension AddController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if self.addTask() {
            self.navigateBack()
        }
        return false
    }
}
