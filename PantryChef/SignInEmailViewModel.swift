//
//  SignInEmailViewModel.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 20.11.23.
//

import SwiftUI

// SignInEmailViewModel is the ViewModel for handling sign in with email.
class SignInEmailViewModel: ObservableObject{
    // Published properties for two-way binding with the view.
    @Published var email = ""
    @Published var password = ""
    
    // Function to handle sign in.
    func signIn() -> Bool {
        // Check if email and password are not empty.
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return false
        }
        
        // Asynchronous task to create a new user.
        Task{
            do{
                // Try to create a new user with the provided email and password.
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
                return true
            } catch {
                // Print the error if user creation fails.
                print("Error: \(error)")
                return false
            }
        }
        return false
    }
}
