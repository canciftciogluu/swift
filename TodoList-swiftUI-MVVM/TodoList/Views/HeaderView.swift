//
//  HeaderView.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("logo2")
                .resizable()
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fit)
            VStack {
                Text("Cano")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Plan Smart, Live Better")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
            .padding(.top, -70)
            Spacer()
        }
    }
}

#Preview {
    HeaderView()
}
