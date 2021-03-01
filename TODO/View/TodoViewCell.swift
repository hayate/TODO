//
//  TodoViewCell.swift
//  TODO
//
//  Created by Andrea Belvedere on 2021/03/01.
//

import UIKit


class TodoViewCell: UITableViewCell {
    public static let Identifier: String = "TodoViewCell"

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!

    private let doneImage = UIImage(systemName: "circlebadge.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    private let todoImage = UIImage(systemName: "circlebadge")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)

    private var todo: Todo! {
        didSet {
            todoLabel.text = todo.todo
            self.setButtonImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupUI()
    }

    private func setupUI() -> Void {
        selectionStyle = .none
        todoLabel.text = ""
        doneButton.setImage(todoImage, for: .normal)
        doneButton.setTitle("", for: .normal)
    }

    @IBAction func onDoneButtonTap(_ sender: Any) {
        todo.done.toggle()
        self.setButtonImage()
    }

    private func setButtonImage() -> Void {
        if todo.done {
            doneButton.setImage(doneImage, for: .normal)
        } else {
            doneButton.setImage(todoImage, for: .normal)
        }
    }

    public func setTodo(todo: Todo) -> Void {
        self.todo = todo
    }
}
