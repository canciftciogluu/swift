import SwiftUI
import FirebaseAuth

struct MainView: View {
    @StateObject var navbarViewModel = NavbarViewModel()  // ✅ Navbar için ViewModel ekledik

    var isUserLoggedIn: Bool {
        Auth.auth().currentUser != nil
    }

    var body: some View {
        NavigationStack {
            if isUserLoggedIn {
                accountView
            } else {
                LoginView()
            }
        }
    }

    @ViewBuilder
    var accountView: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            TabView(selection: $navbarViewModel.selectedTab) {
                ToDoListView(userId: Auth.auth().currentUser?.uid ?? "",
                             viewModel: ToDoListViewViewModel(userId: Auth.auth().currentUser?.uid ?? ""))
                    .tag(0)
                    .toolbar(.hidden)

                NewItemView(selectedTab: $navbarViewModel.selectedTab)
                    .tag(1)
                    .toolbar(.hidden)

                ProfileView()
                    .tag(2)
                    .toolbar(.hidden)
            }
            .accentColor(.blue)

            // ✅ **Custom Navbar**
            NavbarView(viewModel: navbarViewModel)
                .edgesIgnoringSafeArea(.bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

// ✅ **Önizleme**
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
