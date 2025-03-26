import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var selectedTab: Int
    @State private var selectedCategory: TaskCategory?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Create a Task")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Task Title")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.leading, 5)

                        TextField("", text: $viewModel.title, prompt: Text("Enter task title...").foregroundColor(.white.opacity(0.7)))
                            .padding()
                            .frame(height: 50)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .frame(maxWidth: UIScreen.main.bounds.width - 50)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Details")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.leading, 5)

                        TextField("", text: $viewModel.description, prompt: Text("Add more details...").foregroundColor(.white.opacity(0.7)))
                            .padding()
                            .frame(height: 50)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .frame(maxWidth: UIScreen.main.bounds.width - 50)
                    }

                    // 📌 **Kategori Seçme**
                    TaskCategoryView(selectedCategory: $selectedCategory)
                        .onChange(of: selectedCategory) { newCategory in
                            if let newCategory = newCategory {
                                viewModel.selectedCategory = newCategory // ✅ **Kategori güncellendiğinde ViewModel'e aktar!**
                            }
                        }

                    VStack(alignment: .leading, spacing: 25) {
                        Text("Deadline")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.leading, 5)

                        DatePicker("", selection: $viewModel.dueDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(15)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 310)
                    }

                    // 📌 **Güncellenmiş Add Task Butonu**
                    Button(action: addTask) {
                        Text("Add Task")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: UIScreen.main.bounds.width - 50)
                            .frame(height: 60)
                            .background(
                                viewModel.isFormValid ?
                                AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                                :
                                AnyShapeStyle(Color.gray)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(color: viewModel.isFormValid ? Color.purple.opacity(0.5) : Color.clear,
                                    radius: 8, x: 0, y: 5)
                            .scaleEffect(viewModel.isFormValid ? 1.0 : 0.98)
                    }
                    .disabled(!viewModel.isFormValid)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.selectedCategory = nil
        }
    }

    func addTask() {
        viewModel.saveTask()
        selectedTab = 0
    }
}

#Preview {
    NewItemView(selectedTab: .constant(0))
}
