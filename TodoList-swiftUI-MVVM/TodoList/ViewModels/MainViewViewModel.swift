//
//  MainViewViewModel.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//n
import Foundation
import FirebaseAuth

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var isUserLoggedIn: Bool = false // ✅ Kullanıcı giriş yapmış mı kontrolü eklendi
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
                self?.isUserLoggedIn = (user != nil) // ✅ Kullanıcı oturum açtı mı güncelle
            }
        }
    }

    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func checkIfUserIsSignedIn() {
        DispatchQueue.main.async {
            self.isUserLoggedIn = (Auth.auth().currentUser != nil)
            self.currentUserId = Auth.auth().currentUser?.uid ?? ""
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isUserLoggedIn = false
                self.currentUserId = ""
            }
        } catch {
            print("❌ Error signing out: \(error.localizedDescription)")
        }
    }
}
