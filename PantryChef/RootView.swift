//
//  RootView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 20.11.23.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    
    var body: some View{
        ZStack{
            NavigationStack{
                HomeView(showSignInView: $showSignInView)
            }
        }
        .onAppear(){
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                StartView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
