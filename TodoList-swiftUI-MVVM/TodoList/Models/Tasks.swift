//
//  TaskModel.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let dueDate: Date
    var isCompleted: Bool // gorev tamamlandi mi ??
    let category: TaskCategory // gorev kategorisi
}
