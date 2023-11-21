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

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

struct HomeView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    
    let categories = ["All", "Italian", "French", "Greek", "Chinese", "German", "Indian"]
    let dishes: [String: [Dish]] = [
        "Italian": [Dish(name: "Pizza", image: "pizzaImage"), Dish(name: "Pasta", image: "pastaImage")],
        "French": [Dish(name: "Croissant", image: "croissantImage"), Dish(name: "Baguette", image: "baguetteImage")],
    ]
    
    var body: some View {
        VStack {
            if selectedTab == 0 {
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
                    Button(action: {
                        // Filter action
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
            
            
            TabView(selection: $selectedTab) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(categories, id: \.self) { category in
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(categories, id: \.self) { category in
                                            Button(action: {
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
                                
                                let columns = [
                                    GridItem(.flexible(), spacing: 20),
                                    GridItem(.flexible(), spacing: 20)
                                ]

                                var currentDishes: [Dish] {
                                    if selectedCategory == "All" {
                                        return dishes.values.flatMap { $0 }
                                    } else {
                                        return dishes[selectedCategory] ?? []
                                    }
                                }

                                ScrollView(.vertical, showsIndicators: false) {
                                    LazyVGrid(columns: columns, spacing: 20) {
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
