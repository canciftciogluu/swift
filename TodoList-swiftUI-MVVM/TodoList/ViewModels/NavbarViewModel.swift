//
//  NavbarViewViewModel.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 18.02.2025.
//


import Foundation
import SwiftUI

class NavbarViewModel: ObservableObject {
    @Published var selectedTab: Int = 0  // Seçili tab yönet 
}
