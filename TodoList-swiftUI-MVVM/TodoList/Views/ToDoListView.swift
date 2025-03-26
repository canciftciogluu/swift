import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel: ToDoListViewViewModel
    private let userId: String
    @State private var isEditing: Bool = false

    init(userId: String, viewModel: ToDoListViewViewModel) {
        self.userId = userId
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            // 🌈 **Tam ekran arka plan düzeltildi**
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("To-Do List")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: { withAnimation { isEditing.toggle() } }) {
                        Text(isEditing ? "Done" : "Edit")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                if viewModel.tasks.isEmpty {
                    Text("You haven’t added any tasks yet! 🚀")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.title2)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.tasks, id: \.id) { task in
                                TaskRowView(task: task, viewModel: viewModel, isEditing: isEditing)
                                    .padding(.horizontal, 15)
                            }
                        }
                        .padding(.top, 10)
                        .background(Color.clear) // 🔥 **Arka planın mor görünmesini sağladık**
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchTasks()
        }
    }
}
