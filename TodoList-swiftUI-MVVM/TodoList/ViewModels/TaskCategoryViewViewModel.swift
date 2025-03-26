//
//  TaskCategoryViewViewModel.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 19.02.2025.
//

import Foundation

class TaskCategoryViewModel: ObservableObject {
    @Published var categories: [TaskCategory] = [
        TaskCategory(name: "Work", color: "#FF5733"),
        TaskCategory(name: "Personal", color: "#33FF57"),
        TaskCategory(name: "Health", color: "#5733FF"),
        TaskCategory(name: "Shopping", color: "#FFC300")
    ]
}
