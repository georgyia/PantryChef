//
//  HomeView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI

// ViewModel for handling settings related tasks.
@MainActor
class SettingsViewModel: ObservableObject{
    // Function to sign out the current user.
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    // Function to reset the password for the current user.
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
}

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

struct HomeView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    // Binding to control the visibility of the sign in view.
    @Binding var showSignInView: Bool
    
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    
    // Categories and dishes for the home view.
    let categories = ["All", "Italian", "French", "Greek", "Chinese", "German", "Indian"]
    let dishes: [String: [Dish]] = [
        "Italian": [Dish(name: "Pizza", image: "pizzaImage"), Dish(name: "Pasta", image: "pastaImage")],
        "French": [Dish(name: "Croissant", image: "croissantImage"), Dish(name: "Baguette", image: "baguetteImage")],
    ]
    
    var body: some View {
        VStack {
            if selectedTab == 0 {
                // Greeting and search bar.
                HStack {
                    Text("Hello Georgy")                    .font(.custom("Poppins", size: 25))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 100)
                HStack {
                    Text("What are you cooking today?")
                        .font(.custom("Poppins", size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)))
                        .padding(.horizontal, 30)
                        .padding(.top, 5)
                    Spacer()
                }
                HStack {
                    TextField("Search recipe", text: $searchText)
                        .padding(.leading, 38)
                        .frame(width: 300, height: 40)
                        .background(Color.white)
                        .cornerRadius(20)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemFill), lineWidth: 1)
                        )
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Spacer()
                            }
                                .padding(.horizontal, 10)
                            
                        )
                        .padding(.leading, 20)
                    Spacer()
                    // Filter button.
                    Button(action: {
                        // Filter
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color(red: 113/255, green: 177/255, blue: 161/255))
                            .cornerRadius(5)
                    }
                    .padding(.trailing, 30)
                    
                }
                .padding(.top, 20)
            }
            
            // TabView for Home and Settings.
            TabView(selection: $selectedTab) {
                // Home tab.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        // Loop through each category.
                        ForEach(categories, id: \.self) { category in
                            VStack {
                                // Horizontal scroll view for each category.
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        // Loop through each category for the button.
                                        ForEach(categories, id: \.self) { category in
                                            Button(action: {
                                                // Set the selected category when a category button is clicked.
                                                selectedCategory = category
                                            }) {
                                                Text(category)
                                                    .padding()
                                                    .background(selectedCategory == category ? Color(red: 113/255, green: 177/255, blue: 161/255) : Color.white)
                                                    .foregroundColor(selectedCategory == category ? .white : Color(red: 113/255, green: 177/255, blue: 161/255))
                                                    .cornerRadius(10)
                                            }
                                            .padding(.horizontal,3)
                                        }
                                    }
                                    .padding(.leading)
                                }
                                
                                // Grid layout for the dishes.
                                let columns = [
                                    GridItem(.flexible(), spacing: 20),
                                    GridItem(.flexible(), spacing: 20)
                                ]
                                
                                // Determine the current dishes based on the selected category.
                                var currentDishes: [Dish] {
                                    if selectedCategory == "All" {
                                        return dishes.values.flatMap { $0 }
                                    } else {
                                        return dishes[selectedCategory] ?? []
                                    }
                                }
                                
                                // Vertical scroll view for the dishes.
                                ScrollView(.vertical, showsIndicators: false) {
                                    LazyVGrid(columns: columns, spacing: 20) {
                                        // Loop through each dish in the current dishes.
                                        ForEach(currentDishes, id: \.id) { dish in
                                            VStack {
                                                Image(dish.image)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 150, height: 200)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    .overlay(
                                                        Text(dish.name)
                                                            .font(.title2)
                                                            .padding()
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                                                    )
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.trailing,500)
                                }
                            }
                        }
                    }
                    .padding(.leading)
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                    
                }
                .tag(0)
                
                // Settings tab.
                List{
                    Button("Reset password"){
                        Task{
                            do{
                                try await viewModel.resetPassword()
                            } catch {
                                print(error)
                            }
                        }
                    }.foregroundColor(Color(red: 113/255, green: 177/255, blue: 161/255))
                    Button("Log out"){
                        Task{
                            do{
                                try viewModel.signOut()
                                showSignInView = true
                            } catch {
                                print(error)
                            }
                        }
                    }.foregroundColor(Color(red: 113/255, green: 177/255, blue: 161/255))
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(1)
            }
            .accentColor(.white)
            .onAppear() {
                UITabBar.appearance().backgroundColor = UIColor(red: 113/255, green: 177/255, blue: 161/255, alpha: 1)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HomeView(showSignInView: .constant(false))
}
