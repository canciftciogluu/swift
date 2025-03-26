//
//  TaskCategory.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 19.02.2025.
//

import Foundation
import SwiftUI

struct TaskCategory: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let color: String  // HEX kodu veya renk ismi olarak saklanabilir
    
    init(id: String = UUID().uuidString, name: String, color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
}
let sampleCategories = [
    TaskCategory(name: "Work", color: "red"),
    TaskCategory(name: "Personal", color: "blue"),
    TaskCategory(name: "Shopping", color: "green"),
    TaskCategory(name: "Home", color: "purple")
]
