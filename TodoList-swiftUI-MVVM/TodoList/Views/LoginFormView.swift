//
//  LoginFormView.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import SwiftUI

struct LoginFormView: View {
    @ObservedObject var viewModel: LoginViewViewModel

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))

            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
                SecureField("Password", text: $viewModel.password)
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))

            if !viewModel.error.isEmpty {
                Text(viewModel.error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 20) // Kenarlardan hizalamak için padding eklendi
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(viewModel: LoginViewViewModel())
    }
}
