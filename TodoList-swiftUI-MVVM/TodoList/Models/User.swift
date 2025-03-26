//
//  User.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joinedDate: TimeInterval
}
