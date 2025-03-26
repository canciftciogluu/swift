//
//  TodoListApp.swift
//  TodoList
//
//  Created by Mohammad  on 03/11/2024.
//

import SwiftUI
import FirebaseCore




@main
struct TodoListApp: App {
    
    @StateObject  var mainViewvViewModel = MainViewViewModel()
    
    init() {
        FirebaseApp.configure() // 🔥 Firebase başlatılıyor
    }


    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
                
            
            .environmentObject(mainViewvViewModel)
        }
    }
}
