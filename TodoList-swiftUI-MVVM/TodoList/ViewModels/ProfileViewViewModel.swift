//
//  ProfileViewViewModel.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class ProfileViewViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var tasks: [TaskModel] = [] // ✅ ToDo list verisini saklamak için
    @Published var isLoggedOut = false // ✅ Çıkış yapıldığında güncellenecek

    private let db = Firestore.firestore()

    init() {
        fetchUserData()
        fetchTasks()
    }

    // ✅ Kullanıcı verilerini çek
    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userId).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                DispatchQueue.main.async {
                    self.firstName = data["firstName"] as? String ?? "Unknown"
                    self.lastName = data["lastName"] as? String ?? "Unknown"
                    self.email = data["email"] as? String ?? "No Email"
                }
            }
        }
    }

    // ✅ Kullanıcının görevlerini çek
    func fetchTasks() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(userId).collection("todos").addSnapshotListener { snapshot, error in
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    self.tasks = documents.compactMap { doc -> TaskModel? in
                        let data = doc.data()
                        let title = data["title"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let dueDate = (data["dueDate"] as? Timestamp)?.dateValue() ?? Date()
                        let isCompleted = data["isCompleted"] as? Bool ?? false
                        let categoryData = data["category"] as? [String: Any] ?? [:]
                        
                        let category = TaskCategory(
                            name: categoryData["name"] as? String ?? "Uncategorized",
                            color: categoryData["color"] as? String ?? "#FFFFFF"
                        )

                        return TaskModel(id: doc.documentID, title: title, description: description, dueDate: dueDate, isCompleted: isCompleted, category: category)
                    }
                }
            }
        }
    }

    // ✅ Toplam görev sayısını hesapla
    var totalTasks: Int {
        tasks.count
    }

    // ✅ Tamamlanan görevleri hesapla
    var completedTasks: Int {
        tasks.filter { $0.isCompleted }.count
    }

    // ✅ Kalan görevleri hesapla
    var remainingTasks: Int {
        tasks.filter { !$0.isCompleted }.count
    }

    // ✅ Kullanıcının çıkış zamanını Firestore'a kaydet ve çıkış yap
    func logout() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let logoutTime = Timestamp(date: Date())  // 🔥 Çıkış zamanı Firestore formatında
        db.collection("users").document(userId).updateData([
            "lastLogout": logoutTime  // 🔥 Firestore'da çıkış zamanını güncelle
        ]) { error in
            if let error = error {
                print("❌ Firestore çıkış zamanı güncellenemedi: \(error.localizedDescription)")
            } else {
                print("✅ Kullanıcı çıkış zamanı Firestore'a kaydedildi.")
            }
        }

        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedOut = true  // ✅ Kullanıcı çıkış yaptı, yönlendirme sağlanacak
            }
        } catch {
            print("❌ Firebase çıkış hatası: \(error.localizedDescription)")
        }
    }
}
