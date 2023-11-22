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
    
    // Function to log in a user with email and password.
    func login(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Call the signIn method of Firebase Auth.
        // This method is asynchronous and uses a completion handler to handle the result.
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            // The completion handler is called when the sign-in operation is finished.
            // It has two parameters: 'result' and 'error'.
            // 'result' is the result of the sign-in operation.
            // 'error' is any error that occurred during the sign-in operation.
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                print("success")
                completion(true)
            }
        }
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
    
    // Function to send a password reset email.
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    
    // Function to sign out the currently authenticated user.
    func signOut() throws {
        try Auth.auth().signOut()
    }

    
}
