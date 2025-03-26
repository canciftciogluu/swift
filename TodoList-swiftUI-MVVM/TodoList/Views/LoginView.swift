//
//  LoginView.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        ZStack {
            // 🔥 Arka Plan
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.9)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()

            VStack {
                Spacer()

                // 🔹 Logo ve Başlık
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 5)

                Text("iCARE")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)

                Text("Plan Smart, Live Better")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 10)

                // 📌 Login Form
                LoginFormView(viewModel: viewModel)

                // 📌 Login Butonu
                LoginButtonView(action: {
                    viewModel.login()
                })
                .padding(.top, 10)

                // 📌 Register Alanı
                VStack {
                    Text("Don't have an account?")
                        .foregroundColor(.white)

                    NavigationLink(destination: RegisterView()) {
                        Text("Register!")
                            .foregroundColor(.orange)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 50)

                Spacer()
            }
            .padding()
        }
        // ✅ **Başarıyla giriş yapıldığında `ToDoListView`'e yönlendir!**
        .fullScreenCover(isPresented: $viewModel.navigateToTodoList) {
            MainView()
        }
    }
}

// ✅ **Önizleme**
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
