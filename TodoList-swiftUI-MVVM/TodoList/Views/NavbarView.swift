import SwiftUI

struct NavbarView: View {
    @ObservedObject var viewModel: NavbarViewModel  // ✅ Navbar için ViewModel

    var body: some View {
        HStack {
            NavbarButton(icon: "list.bullet", label: "ToDos", selectedTab: $viewModel.selectedTab, tag: 0)
            Spacer()
            NavbarButton(icon: "plus.circle.fill", label: "New Task", selectedTab: $viewModel.selectedTab, tag: 1)
            Spacer()
            NavbarButton(icon: "person.crop.circle", label: "Profile", selectedTab: $viewModel.selectedTab, tag: 2)
        }
        .padding(.horizontal, 30) // 🔥 Yan boşlukları artırarak içerikleri ortaladık
        .padding(.vertical, 22) // 🔥 Dikey padding artırıldı (önceden 18'di)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white.opacity(0.2))
                    .background(.ultraThinMaterial)
            }
        )
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        .frame(maxWidth: .infinity, maxHeight: 95) // 🔥 **Navbar yüksekliği 80'den 95'e çıkarıldı**
        .edgesIgnoringSafeArea(.bottom) // 📌 Alt boşluk tamamen kaldırıldı
    }
}

// ✅ **Navbar Butonu**
struct NavbarButton: View {
    let icon: String
    let label: String
    @Binding var selectedTab: Int
    let tag: Int

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                selectedTab = tag
            }
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 34, weight: .bold))  // 🔥 **Simge boyutu 30'dan 34'e çıkarıldı**
                    .foregroundColor(selectedTab == tag ? .white : .gray.opacity(0.8))
                    .background(
                        Circle()
                            .fill(
                                selectedTab == tag ?
                                AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                             startPoint: .topLeading,
                                                             endPoint: .bottomTrailing))
                                : AnyShapeStyle(Color.clear)
                            )
                            .frame(width: 55, height: 55) // 🔥 **Daha büyük butonlar**
                            .shadow(radius: selectedTab == tag ? 8 : 0)
                    )

                Text(label)
                    .font(.system(size: 18, weight: .bold))  // 🔥 **Yazı boyutu 16'dan 18'e çıkarıldı**
                    .foregroundColor(selectedTab == tag ? .white : .gray.opacity(0.8))
            }
        }
    }
}

// ✅ **Preview**
struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                NavbarView(viewModel: NavbarViewModel())
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
