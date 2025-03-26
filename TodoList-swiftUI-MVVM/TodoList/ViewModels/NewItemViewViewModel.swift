//
//  NewItemViewViewModel.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import FirebaseAuth
import FirebaseFirestore

class NewItemViewViewModel: ObservableObject {
    @Published var title: String = "" {
        didSet { validateForm() }
    }
    @Published var description: String = "" {
        didSet { validateForm() }
    }
    @Published var dueDate: Date = Date()
    @Published var selectedCategory: TaskCategory? = nil {
        didSet { validateForm() }
    }
    @Published var isFormValid: Bool = false  // ✅ Butonun aktif olup olmadığını kontrol eden state

    private func validateForm() {
        DispatchQueue.main.async {
            self.isFormValid = !self.title.isEmpty &&
                               !self.description.isEmpty &&
                               self.selectedCategory != nil
        }
    }

    func saveTask() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("❌ User ID not found!")
            return
        }

        guard let category = selectedCategory else {
            print("❌ Category is not selected!")
            return
        }

        let db = Firestore.firestore()
        let newTask: [String: Any] = [
            "title": title,
            "description": description,
            "dueDate": Timestamp(date: dueDate),
            "isCompleted": false,
            "category": [
                "name": category.name,
                "color": category.color // ✅ Renk kaydediliyor!
            ]
        ]

        // Kullanıcının todos koleksiyonuna yeni görev ekle
        db.collection("users").document(userId).collection("todos").addDocument(data: newTask) { error in
            if let error = error {
                print("❌ Firestore Task Save Error: \(error.localizedDescription)")
            } else {
                print("✅ Task successfully added for user: \(userId) with category: \(category.name), color: \(category.color)")
            }
        }
    }
}
