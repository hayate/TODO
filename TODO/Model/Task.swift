//
//  Task.swift
//  TODO
//
//  Created by Andrea Belvedere on 2021/03/01.
//

import Foundation


struct Todo: Equatable, Codable {
    var todo: String
    var done: Bool
}

class Task {
    private static let Instance: Task = Task()

    private var tasks: [Todo]!

    private init() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            self.tasks = self.fromJSON(data: data)
        } else {
            self.tasks = []
        }

        /*
        tasks = [
            Todo(todo: "Watch byteset videos", done: true),
            Todo(todo: "Make a Todo app", done: false),
            Todo(todo: "Learn Table and Cell Views", done: false),
            Todo(todo: "Build your own amazing app", done: false)
        ]
        */
    }

    public static func getInstance() -> Task {
        return Instance
    }

    public func getTasks() -> [Todo] {
        return tasks
    }

    public func addTask(todo: Todo) -> Void {
        tasks.append(todo)
        if let data = self.toJSON() {
            UserDefaults.standard.set(data, forKey: "tasks")
        }
    }

    public func addTask(todo: String) -> Void {
        tasks.append(Todo(todo: todo, done: false))
        if let data = self.toJSON() {
            UserDefaults.standard.set(data, forKey: "tasks")
        }
    }

    public func removeTask(index: Int) -> Void {
        tasks.remove(at: index)
        if let data = self.toJSON() {
            UserDefaults.standard.set(data, forKey: "tasks")
        }
    }

    public func removeTask(todo: Todo) -> Void {
        self.tasks = tasks.filter {item in
            return item != todo
        }
        if let data = self.toJSON() {
            UserDefaults.standard.set(data, forKey: "tasks")
        }
    }

    public func count() -> Int {
        return tasks.count
    }

    public func getTask(index: Int) -> Todo {
        return tasks[index]
    }

    private func toJSON() -> Data? {
        if let data = try? JSONEncoder().encode(self.tasks) {
            return data
        }
        return nil
    }

    private func fromJSON(data: Data) -> [Todo] {
        do {
            return try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
