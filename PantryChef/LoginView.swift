//
//  LoginView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI
import Firebase

// LoginView is the view where users can sign in to the app.
struct LoginView: View {
    // ViewModel for handling sign in with email.
    @State private var viewModel = SignInEmailViewModel()
    // State variables for handling password reset, showing alerts, and navigation.
    @State private var passwordForgot: Bool = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var showSignInView: Bool
    @State private var signedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Welcome texts.
                Text("Hello,")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 70)
                    .padding(.bottom, 10)
                
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.bottom, 70)
                
                // Text fields for email and password input.
                TextField("Enter Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                SecureField("Enter Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
                // Button for password reset.
                HStack {
                    Button(action: {
                        self.passwordForgot = true
                    }) {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .foregroundColor(.orange)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
                
                // Sign in button.
                Button(action: {
                    AuthenticationManager.shared.login(withEmail: $viewModel.email.wrappedValue, password: $viewModel.password.wrappedValue) { success in
                        // The completion handler is called when the login operation is finished.
                        // The 'success' parameter indicates whether the login was successful.
                        if success {
                            print("Login successful")
                            // UI updates should be done on the main thread.
                            DispatchQueue.main.async {
                                self.showSignInView = false
                                self.signedIn = true
                            }
                        } else {
                            print("Login failed")
                        }
                    }
                }) {
                    HStack {
                        Text("Sign In")
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
                
                // Sign in with social media buttons.
                HStack {
                    Spacer()
                        .frame(width: 50, height: 1)
                        .background(Color.gray)
                    Text(" or Sign in with ")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                        .frame(width: 50, height: 1)
                        .background(Color.gray)
                }
                .padding(.top, 20)
                
                HStack {
                    // Google sign in button.
                    Button(action: {
                    }) {
                        HStack {
                            Image("google_icon")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // Facebook sign in button.
                    Button(action: {
                    }) {
                        HStack {
                            Image("facebook_icon")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                
                Spacer()
                
                // Navigation to SignUpView.
                HStack {
                    Text("Don’t have an account?")
                        .font(.footnote)
                    NavigationLink(destination: SignUpView(showSignInView: $showSignInView)) {
                        Text("Sign up")
                            .font(.footnote)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.bottom, 50)
                
                // Navigation to HomeView after successful sign in.
                NavigationLink (destination: HomeView(showSignInView: $showSignInView), isActive: $signedIn){
                    EmptyView()
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

// Preview of the LoginView for SwiftUI design canvas.
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showSignInView: .constant(false))
    }
}

#Preview {
    LoginView(showSignInView: .constant(false))
}
