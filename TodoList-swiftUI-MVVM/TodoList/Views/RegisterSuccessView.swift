//
//  RegisterSuccessView.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import SwiftUI

struct RegisterSuccessView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 🔥 Premium Gradient Arka Plan
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.9)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                // 💡 Glow Efektleri
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .blur(radius: 100)
                    .offset(x: -150, y: -300)
                
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .blur(radius: 80)
                    .offset(x: 150, y: 250)
                
                VStack(spacing: 20) {
                    // ✅ Başlık ve Onay İkonu
                    HStack {
                        Text("Register Done")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.largeTitle)
                    }
                    .padding(.top, 50)
                    
                    // 📌 Açıklama Metni
                    Text("Welcome to iCARE! Let’s plan smart and live better.🚀 ")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    // 📌 LoginView'e Yönlendiren Buton
                    GoToLoginButtonView()
                }
            }
        }
    }
}

struct RegisterSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSuccessView()
    }
}
