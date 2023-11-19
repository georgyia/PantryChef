//
//  SignUpView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedIn: Bool = false
    @State private var passwordForgot: Bool = false
    @State private var termsAccepted: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Create an account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 70)
                    .padding(.bottom, 50)
                
                TextField("Enter Name", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                TextField("Enter Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                SecureField("Enter Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                SecureField("Confirm Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
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
                Button(action: {
                    self.isSignedIn = true
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
                .padding(.bottom, 150)
                NavigationLink(destination: HomeView(), isActive: $isSignedIn) {
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

#Preview {
    SignUpView()
}
