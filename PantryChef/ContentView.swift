//
//  ContentView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI

struct ContentView: View {
    @State private var ingredients = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter ingredients", text: $ingredients)
                    .padding()
                
                NavigationLink(destination: RecipeListView(ingredients: self.ingredients)) {
                    Text("Find Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Recipe Finder")
        }
    }
}

struct RecipeListView: View {
    let ingredients: String
    
    // Here you would fetch the recipes based on the ingredients
    // For now, let's just display the ingredients
    var body: some View {
        Text("Recipes for \(ingredients)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
