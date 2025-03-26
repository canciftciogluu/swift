//
//  BigButtonView.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import SwiftUI

struct BigButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true // ✅ Butonun aktif olup olmadığını kontrol edelim

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(
                    isEnabled ?
                    AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                    :
                    AnyShapeStyle(Color.gray)
                )
                .cornerRadius(15)
                .shadow(color: isEnabled ? Color.purple.opacity(0.4) : Color.clear,
                        radius: 10, x: 0, y: 5)
                .scaleEffect(isEnabled ? 1.0 : 0.98)
        }
        .disabled(!isEnabled) // ✅ Eğer form tamamlanmadıysa buton pasif olsun
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    VStack {
        BigButton(title: "Register", action: {})
    }
    .frame(width: 300)
}
