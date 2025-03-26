//
//  TaskCategoryView.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 19.02.2025.
//

import SwiftUI

struct TaskCategoryView: View {
    @ObservedObject var categoryViewModel = TaskCategoryViewModel()
    @Binding var selectedCategory: TaskCategory?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Category")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 5)

            Menu {
                ForEach(categoryViewModel.categories, id: \.name) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        HStack {
                            Text(category.name)
                            Spacer()
                            Circle()
                                .fill(Color(hex: category.color))  // ✅ Burada doğru kullanıldı
                                .frame(width: 12, height: 12)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedCategory?.name ?? "Select a category")
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 50)
    }
}
