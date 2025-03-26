//
//  RegisterViewViewModel.swift
//  CanoToDoList-App
//
//  Created by Can Ciftcioglu on 16.02.2025.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var error: String = ""
    @Published var isSuccessful: Bool = false
    @Published var navigateToSuccessPage: Bool = false

    private let db = Firestore.firestore()

    init() {
        resetForm()
    }

    func register() {
        if let errorMessage = validateFields() {
            error = errorMessage
            isSuccessful = false
        } else {
            // Proceed with Firebase registration
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.error = error.localizedDescription
                    self.isSuccessful = false
                } else {
                    self.error = ""
                    self.isSuccessful = true
                    // Save user data to Firestore
                    if let userId = result?.user.uid {
                        self.saveUserData(userId: userId)
                    }
                    self.navigateToSuccessPage = true
                }
            }
        }
    }

    private func saveUserData(userId: String) {
        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password // Save the password in Firestore for demonstration purposes only
            
        ]
        db.collection("users").document(userId).setData(userData) { error in
            if let error = error {
                self.error = error.localizedDescription
                self.isSuccessful = false
            } else {
                print("User data saved successfully!")
            }
        }
    }

    private func validateFields() -> String? {
        if firstName.trimmingCharacters(in: .whitespaces).isEmpty ||
            lastName.trimmingCharacters(in: .whitespaces).isEmpty ||
            email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill all fields"
        }
        if !isValidEmail(email) {
            return "Please enter a valid email address"
        }
        if password.count < 6 {
            return "Password must be at least 6 characters"
        }
        if password != confirmPassword {
            return "Passwords do not match"
        }
        return nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func resetForm() {
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        confirmPassword = ""
        error = ""
        isSuccessful = false
        navigateToSuccessPage = false
    }
}
    
   
                
                


