//
//  AddTaskButtonView.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 19.02.2025.
//

import SwiftUI

struct AddTaskButtonView: View {
    var isEnabled: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Add Task")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(
                    isEnabled ?
                    AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                    :
                    AnyShapeStyle(Color.gray)
                )
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: isEnabled ? Color.purple.opacity(0.5) : Color.clear,
                        radius: 8, x: 0, y: 5)
                .scaleEffect(isEnabled ? 1.0 : 0.98)
        }
        .disabled(!isEnabled) // ✅ Eğer form tamamlanmadıysa buton pasif olur
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

struct AddTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButtonView(isEnabled: true, action: {})
            .frame(width: 300)
    }
}

