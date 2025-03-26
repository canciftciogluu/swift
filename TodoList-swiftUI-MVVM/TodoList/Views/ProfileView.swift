import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewViewModel()
    @State private var goal: Int = 0  // Kullanıcının belirlediği hedef
    @State private var showGoalAlert = false  // Hedef güncellendiğinde uyarı göstermek için
    @State private var isLoggedOut = false  // ✅ Logout sonrası yönlendirme için
    
    var body: some View {
        NavigationStack {
            ZStack {
                // ✅ **Arka Plan (Premium Uyum)**
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // 📌 Profil başlığı
                        Text("My Profile")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)

                        // 📌 **Profil Kartı**
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                            
                            Text("\(viewModel.firstName) \(viewModel.lastName)")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text(viewModel.email)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                        .shadow(radius: 5)

                        // 📌 **Görev İstatistikleri**
                        VStack {
                            Text("Task Stats")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack {
                                StatView(number: viewModel.totalTasks, label: "Total Tasks", color: .white)
                                StatView(number: viewModel.completedTasks, label: "Completed", color: .green)
                                StatView(number: viewModel.remainingTasks, label: "Remaining", color: .red)
                            }
                        }

                        // 📌 **Günlük Motivasyon**
                        DailyMotivationView()

                        // 📌 **Hedef Belirleme Alanı**
                        VStack(alignment: .leading, spacing: 4) {
                            Text("🎯 Goal Setting")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("Set a target for the number of tasks you want to complete.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))

                            HStack {
                                TextField("Enter your goal", value: $goal, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                Button("Set Goal") {
                                    showGoalAlert = true
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .padding(.horizontal)
                            .alert(isPresented: $showGoalAlert) {
                                Alert(title: Text("Goal Updated!"), message: Text("Your new goal is \(goal) tasks!"), dismissButton: .default(Text("OK")))
                            }

                            // 🎉 Kullanıcı hedefe ulaştığında mesaj gösterme
                            if viewModel.completedTasks >= goal && goal > 0 {
                                Text("🎉 Congratulations! You've reached your goal!")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                    .bold()
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .shadow(radius: 5)

                        // *Logout Butonu (LogoutButtonView Kullanıldı)**
                        LogoutButtonView(action: {
                            viewModel.logout()
                            isLoggedOut = true
                        })
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.fetchUserData()
                }
                // ✅ **Logout sonrası LoginView'e yönlendirme**
                .fullScreenCover(isPresented: $isLoggedOut, content: {
                    LoginView()
                })
            }
        }
    }
}

// ✅ **Görev İstatistikleri için yardımcı görünümler**
struct StatView: View {
    var number: Int
    var label: String
    var color: Color
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.title2)
                .bold()
                .foregroundColor(color)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
    }
}

// ✅ **Günlük Motivasyon Görünümü**
struct DailyMotivationView: View {
    let quote = "The secret of getting ahead is getting started."
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                
                Text("Daily Motivation")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Text(quote)
                .font(.subheadline)
                .italic()
                .foregroundColor(.white.opacity(0.8))
                .padding(.top, 6)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

// ✅ **Önizleme**
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ProfileView()
        }
    }
}
