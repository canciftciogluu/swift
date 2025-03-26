//
//  itemModel.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 18.02.2025.
//


import Foundation

// immutable Struct


struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    
    init (id: String = UUID().uuidString, title: String, iscompleted: Bool){
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = iscompleted
    }
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, iscompleted: !isCompleted)
    }
}
