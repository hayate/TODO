//
//  ViewController.swift
//  TODO
//
//  Created by Andrea Belvedere on 2021/03/01.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let tasks: Task = Task.getInstance()
    private let addImage = UIImage(systemName: "plus.app")?.withTintColor(.label, renderingMode: .alwaysOriginal)


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) -> Void {
        super.viewWillAppear(animated)

        if tableView.numberOfRows(inSection: 0) != tasks.count() {
            tableView.reloadData()
        }
    }

    private func setupUI() -> Void {
        title = "TODOs"
        tableView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(onAddButtonTap(_:)))
    }


    @objc private func onAddButtonTap(_ sender: UIBarButtonItem) -> Void {
        performSegue(withIdentifier: "toAddController", sender: self)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TodoViewCell.Identifier, for: indexPath) as! TodoViewCell
        cell.setTodo(todo: tasks.getTask(index: indexPath.item))

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.removeTask(index: indexPath.item)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

