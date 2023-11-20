//
//  AuthenticationManager.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 20.11.23.
//

import Foundation
import FirebaseAuth

// Struct to hold the user data returned from Firebase Auth.
struct AuthDataResultModel{
    let uid: String
    let email: String?
    
    // Initialize with a User object from Firebase Auth.
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}

// Class to manage authentication tasks.
final class AuthenticationManager{
    // Shared instance of the AuthenticationManager.
    static let shared = AuthenticationManager()
    private init(){
        
    }
    
    // Function to get the currently authenticated user.
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        // Check if there's a currently authenticated user.
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        // Return the user data.
        return AuthDataResultModel(user: user)
    }
    
    // Function to create a new user with email and password.
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        // Create the user and get the AuthDataResult.
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        // Return the user data.
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Function to sign out the currently authenticated user.
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}
