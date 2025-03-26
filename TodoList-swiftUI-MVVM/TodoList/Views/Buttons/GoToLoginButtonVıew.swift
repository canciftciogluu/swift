//
//  GoToLoginButton.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 18.02.2025.
//

import SwiftUI

struct GoToLoginButtonView: View {
    var body: some View {
        NavigationLink(destination: LoginView()) {
            Text("Go to Login")
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 220, height: 55)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: Color.purple.opacity(0.5), radius: 8, x: 0, y: 5)
                .scaleEffect(1.0)
        }
        .padding(.top, 30)
    }
}

struct GoToLoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoToLoginButtonView()
        }
    }
}

