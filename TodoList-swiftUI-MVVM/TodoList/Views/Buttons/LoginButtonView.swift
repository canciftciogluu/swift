//
//  LoginButtonView.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 18.02.2025.
//

import SwiftUI

struct LoginButtonView: View {
    var action: () -> Void
    var isEnabled: Bool = true // ✅ Butonun aktif olup olmadığını kontrol edelim

    var body: some View {
        Button(action: action) {
            Text("Login")
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
                .shadow(color: isEnabled ? Color.purple.opacity(0.4) : Color.clear,
                        radius: 10, x: 0, y: 5)
                .scaleEffect(isEnabled ? 1.0 : 0.98)
        }
        .disabled(!isEnabled)
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

struct LoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoginButtonView(action: {}, isEnabled: true)
         
        }
        .frame(width: 300)
    }
}
