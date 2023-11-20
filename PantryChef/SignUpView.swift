//
//  SignUpView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI
import Firebase

// SignUpView is the view where new users can create an account.
struct SignUpView: View {
    
    // ViewModel for handling sign up with email.
    @State private var viewModel = SignInEmailViewModel()
    // State variables for handling user input, showing alerts, and navigation.
    @State private var name: String = ""
    @State private var passwordForgot: Bool = false
    @State private var termsAccepted: Bool = false
    @State private var confirmPassword: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // Title text.
                Text("Create an account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 70)
                    .padding(.bottom, 50)
                
                // Text fields for name, email, and password input.
                TextField("Enter Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                TextField("Enter Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                SecureField("Enter Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                // Text field for password confirmation.
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                // Terms and conditions acceptance toggle.
                HStack {
                    Button(action: {
                        self.termsAccepted.toggle()
                    }) {
                        if termsAccepted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .padding(2)
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        } else {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.orange, lineWidth: 1)
                                .background(Color.white)
                                .frame(width: 17, height: 17)
                        }
                    }
                    .padding(.horizontal,5)
                    Text("Accept terms & Condition")
                        .font(.footnote)
                        .foregroundColor(.orange)
                    Spacer()
                }
                .padding(.bottom, 20)
                
                // Sign up button.
                Button(action: {
                    if viewModel.password != self.confirmPassword {
                        self.alertMessage = "Passwords do not match"
                        self.showingAlert = true
                    } else if !self.termsAccepted {
                        self.alertMessage = "You must accept the terms and conditions"
                        self.showingAlert = true
                    } else {
                        self.showSignInView = viewModel.signIn()
                    }
                }) {
                    HStack {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(red: 113/255, green: 177/255, blue: 161/255))
                    .cornerRadius(10)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                }
                .padding(.bottom, 150)
                
                // Navigation to HomeView after successful sign up.
                NavigationStack {
                    HomeView(showSignInView: $showSignInView)
                }
                
                // Navigation to PasswordForgotView.
                NavigationLink(destination: PasswordForgotView(), isActive: $passwordForgot) {
                    EmptyView()
                }
            }
        }
        .padding()
        .background(Color.white)
    }
    
}

// Preview of the SignUpView for SwiftUI design canvas.
#Preview {
    SignUpView(showSignInView: .constant(false))
}
