//
//  PantryChefApp.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI
import Firebase

// The main application structure.
@main
struct PantryChefApp: App {
    
    // Using AppDelegate to handle application lifecycle events.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // The main scene for the application.
    var body: some Scene {
        WindowGroup {
            // ContentView is the root view of the application.
            ContentView()
        }
    }
}

// AppDelegate is used to respond to application lifecycle events.
class AppDelegate: NSObject, UIApplicationDelegate {
    // This function is called when the application has finished launching.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configuring Firebase when the application launches.
        FirebaseApp.configure()
        return true
    }
}
