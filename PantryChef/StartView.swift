//
//  StartView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//

import SwiftUI

// StartView is the initial view that users see when they open the app.
struct StartView: View {
    // Binding to control the display of the SignInView.
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                StartPageContentView(showSignInView: $showSignInView)
            }
        }
    }
}

// BackgroundView displays the background image and a text overlay.
struct BackgroundView: View {
    var body: some View {
        ZStack {
            Text("100K+ Premium Recipe")
                .foregroundColor(.white)
            Image("LoginViewPic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

// StartPageContentView contains the main content of the start page.
struct StartPageContentView: View {
    // Binding to control the display of the SignInView.
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            TopView()
            MiddleView()
            BottomView(showSignInView: $showSignInView)
        }
    }
}

// TopView displays the logo or main image.
struct TopView: View {
    var body: some View {
        Image("LoginViewPicCook")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.25)
            .padding(.top, 50)
    }
}

// MiddleView displays the main text content.
struct MiddleView: View {
    var body: some View {
        VStack {
            Text("100K+ Premium Recipe")
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top, -50)
            Spacer()
            Text("Get\nCooking")
                .foregroundColor(.white)
                .font(.system(size: UIScreen.main.bounds.width * 0.15))
                .bold()
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 150)
            Spacer()
            Text("Simple way to find Tasty Recipe")
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top, 10)
        }
    }
}

// BottomView contains the navigation link to the SignInView.
struct BottomView: View {
    // Binding to control the display of the SignInView.
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            Spacer()
            // Navigation link to the LoginView(Sign In).
            NavigationLink(destination: LoginView(showSignInView: $showSignInView).navigationBarBackButtonHidden(true)) {
                Text("Start cooking")
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 113/255, green: 177/255, blue: 161/255))
                    .cornerRadius(40)
            }
            Spacer()
        }
    }
}

// Preview of the StartView for SwiftUI design canvas.
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(showSignInView: .constant(false))
    }
}
