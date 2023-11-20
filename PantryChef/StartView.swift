//
//  StartView.swift
//  PantryChef
//
//  Created by Georgy Chomakhashvili on 19.11.23.
//import SwiftUI

import SwiftUI

struct StartView: View {
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

struct StartPageContentView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            TopView()
            MiddleView()
            BottomView(showSignInView: $showSignInView)
        }
    }
}

struct TopView: View {
    var body: some View {        Image("LoginViewPicCook")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.25)
            .padding(.top, 50) // Add padding to move the image down
    }
}

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
                .padding(.top, 150) // Add padding to move the text down
            Spacer()
            Text("Simple way to find Tasty Recipe")
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top, 10)
        }
    }
}

struct BottomView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            Spacer()
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

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(showSignInView: .constant(false))
    }
}
