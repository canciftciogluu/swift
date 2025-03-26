//
//  RegisterFormView.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 18.02.2025.
//

import SwiftUI

struct RegisterFormView: View {
    @ObservedObject var viewModel: RegisterViewViewModel

    var body: some View {
        VStack(spacing: 12) {
            if !viewModel.error.isEmpty {
                Text(viewModel.error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
            }
            
            TextField("First Name", text: $viewModel.firstName)
                .autocapitalization(.words)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            TextField("Last Name", text: $viewModel.lastName)
                .autocapitalization(.words)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: 350)
        .padding(.vertical, 20)
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
}

struct RegisterFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFormView(viewModel: RegisterViewViewModel())
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.9)]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
    }
}
