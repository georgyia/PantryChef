//
//  HomeView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject{
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct HomeView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(showSignInView: .constant(false))
}
