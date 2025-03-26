import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.9)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // 🔹 Logo ve Başlık
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .shadow(radius: 5)

                Text("iCARE")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Plan Smart, Live Better")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 10)

                // 📌 Register Form
                RegisterFormView(viewModel: viewModel)

                // 📌 Register Butonu (Düzeltildi)
                BigButton(title: "Register", action: {
                    viewModel.register()
                })
                .padding(.top, 5)

                // 📌 Already have an account?
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.white)

                    NavigationLink(destination: LoginView()) {
                        Text("Login!")
                            .foregroundColor(.orange)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 5)
            }
            .padding()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
