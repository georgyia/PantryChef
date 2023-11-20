//
//  SignInEmailViewModel.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 20.11.23.
//

import SwiftUI

class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return false
        }
        
        Task{
            do{
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
                return true
            } catch {
                print("Error: \(error)")
                return false
            }
        }
        return false
    }
}
