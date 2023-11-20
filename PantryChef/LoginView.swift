
//
//  LoginView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI
import Firebase


struct LoginView: View {
    @State private var viewModel = SignInEmailViewModel()
    @State private var passwordForgot: Bool = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var showSignInView: Bool
    @State private var signedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello,")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 70)
                    .padding(.bottom, 10)
                
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.bottom, 70)
                
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
                Button(action: {
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    self.showSignInView = authUser == nil
                    print("User - \(String(describing: authUser))")
                    if(!(self.showSignInView)){
                        self.signedIn = true
                    }
                    print("Signed In - \(self.signedIn)")
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
                NavigationLink (destination: HomeView(showSignInView: $showSignInView), isActive: $signedIn){
                    EmptyView()
                }
                NavigationLink(destination: PasswordForgotView(), isActive: $passwordForgot) {
                    EmptyView()
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showSignInView: .constant(false))
    }
}

#Preview {
    LoginView(showSignInView: .constant(false))
}

