//
//  LoginViewViewModel.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var navigateToTodoList: Bool = false
    @Published var isUserLoggedIn: Bool = false
    @Published var currentUserId: String = ""
    
    func checkIfUserIsSignedIn() {
        if let user = Auth.auth().currentUser {
            isUserLoggedIn = true
            currentUserId = user.uid
        } else {
            isUserLoggedIn = false
            currentUserId = ""
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                switch error.code {
                case AuthErrorCode.invalidEmail.rawValue,
                     AuthErrorCode.wrongPassword.rawValue,
                     AuthErrorCode.userNotFound.rawValue:
                    self.error = "Incorrect email or password"
                default:
                    self.error = error.localizedDescription
                }
                self.navigateToTodoList = false
            } else {
                self.error = ""
                self.navigateToTodoList = true
                self.isUserLoggedIn = true
                if let user = result?.user {
                    self.currentUserId = user.uid
                }
            }
        }
    }
}
