
//
//  TaskRowView.swift
//  iCare ToDoList-App
//
//  Created by Can Ciftcioglu on 19.02.2025.
//

import SwiftUI

struct TaskRowView: View {
    let task: TaskModel
    let viewModel: ToDoListViewViewModel
    let isEditing: Bool

    var body: some View {
        HStack {
            if isEditing {
                Button(action: {
                    viewModel.deleteTaskById(task.id)
                }) {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(10)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                .padding(.trailing, 10)
            }

            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .strikethrough(task.isCompleted, color: .gray)

                Text(task.description)
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.8))
                    .strikethrough(task.isCompleted, color: .gray)

                Text("Due: \(formattedDate(task.dueDate))")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.7))
                    .strikethrough(task.isCompleted, color: .gray)
            }
            Spacer()
            Button(action: {
                viewModel.toggleTaskCompletion(task: task)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .black)
                    .font(.system(size: 28))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(hex: task.category.color)) // ✅ **Kategori rengi uygulanıyor**
        )
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
        .opacity(1.0) // ✅ **Soluk görünümü düzelt**
    }
}

// ✅ **Date Formatter**
func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}

// ✅ **Preview**
struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(
            task: TaskModel(id: "1", title: "Sample Task", description: "This is a test task.", dueDate: Date(), isCompleted: false, category: TaskCategory(name: "Work", color: "#FF5733")),
            viewModel: ToDoListViewViewModel(userId: "testUser"),
            isEditing: false
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
