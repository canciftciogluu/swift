import Foundation
import FirebaseFirestore

class ToDoListViewViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    private let db = Firestore.firestore()
    private let userId: String

    init(userId: String) {
        self.userId = userId
        fetchTasks()
    }

    // 🔹 Firestore'dan görevleri çekme
    func fetchTasks() {
        db.collection("users").document(userId).collection("todos").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("❌ Error fetching tasks: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.tasks = documents.compactMap { doc in
                    let data = doc.data()
                    print("🔥 Firestore Task Data:", data) // Debug için Firestore verisini yazdırıyoruz
                    
                    let id = doc.documentID
                    let title = data["title"] as? String ?? "Untitled Task"
                    let description = data["description"] as? String ?? ""
                    let dueDate = (data["dueDate"] as? Timestamp)?.dateValue() ?? Date()
                    let isCompleted = data["isCompleted"] as? Bool ?? false

                    // ✅ Kategori Bilgisi
                    let categoryName = data["category"] as? String ?? "Uncategorized"
                    let categoryColor = self.getCategoryColor(for: categoryName) // 🔥 Renk atamasını düzenledik

                    let category = TaskCategory(name: categoryName, color: categoryColor)

                    return TaskModel(id: id, title: title, description: description, dueDate: dueDate, isCompleted: isCompleted, category: category)
                }
            }
        }
    }

    // 🔹 **Silme Fonksiyonu**: Görevi ID ile Firestore'dan siler
    func deleteTaskById(_ taskId: String) {
        db.collection("users").document(userId).collection("todos").document(taskId).delete { error in
            if let error = error {
                print("❌ Error deleting task: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.tasks.removeAll { $0.id == taskId }
                }
            }
        }
    }

    // 🔹 **Tamamlama Durumunu Değiştirme**
    func toggleTaskCompletion(task: TaskModel) {
        let newStatus = !task.isCompleted
        db.collection("users").document(userId).collection("todos").document(task.id).updateData([
            "isCompleted": newStatus
        ]) { error in
            if let error = error {
                print("❌ Error updating task: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                        self.tasks[index].isCompleted = newStatus
                    }
                }
            }
        }
    }
    
    // ✅ **Kategori İsmi ile Renk Ataması**
    func getCategoryColor(for categoryName: String) -> String {
        switch categoryName.lowercased() {
            case "work": return "#FF5733"
            case "personal": return "#33FF57"
            case "health": return "#5733FF"
            case "shopping": return "#FFC300"
            default: return "#CCCCCC" // Varsayılan gri renk
        }
    }
}
