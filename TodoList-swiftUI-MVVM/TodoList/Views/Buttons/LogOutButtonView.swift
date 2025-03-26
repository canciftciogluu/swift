//
//  LogOutButtonView.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 18.02.2025.
//

import SwiftUI

struct LogoutButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Log Out")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .cornerRadius(12)
                .shadow(radius: 5)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}

struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView(action: {})
            .frame(width: 300)
    }
}

