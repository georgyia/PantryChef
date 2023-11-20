//
//  RootView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 20.11.23.
//

import SwiftUI

// RootView is the main view of the application
struct RootView: View {
    // This state variable is used to control the display of the SignInView
    @State private var showSignInView: Bool = false
    
    var body: some View{
        // A ZStack is used to overlay different views
        ZStack{
            NavigationStack{
                // The HomeView is the main view of the app, it takes a binding to showSignInView
                HomeView(showSignInView: $showSignInView)
            }
        }
        .onAppear(){
            // Try to get the authenticated user
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            // If there is no authenticated user, show the SignInView
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                // The StartView is the first view of the SignIn process, it takes a binding to showSignInView
                StartView(showSignInView: $showSignInView)
            }
        }
    }
}

// This is a preview of the RootView
#Preview {
    RootView()
}
