//
//  WelcomeScreen.swift
//  SoleMate
//
//  Created by Carlos Carrillo-Sandoval on 6/8/25.
//

import SwiftUI
import FirebaseAuth

struct WelcomeScreen: View {
    @State private var goToRegister = false
    @State private var goToSignIn   = false
    @State private var goToHome     = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("shoes-1")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(AppConstants.Colors.backgroundOverlay)
                    
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            Image("sole-mate-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.height * 0.1)
                            
                            Image("sole-mate-logo-text")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.6)
                        }
                        
                        Spacer()
                        
                        Text("The right fit for your feet, the right step for your health")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 32)
                            .foregroundStyle(Color.smBlack)
                        
                        Spacer()
                        
                        VStack(spacing: 16) {
                            Button("Create Account") {
                                goToRegister = true
                            }
                            .fontWeight(.bold)
                            .frame(maxWidth: 148)
                            .padding()
                            .background(Color.smRed)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            
                            Button("Continue As Guest") {
                                try? Auth.auth().signOut()
                                goToHome = true
                            }
                            .underline()
                            .foregroundColor(.primary)
                            
                            Text("Already have an account?")
                                .font(.system(size: 12))
                            
                            Button("Sign In") {
                                goToSignIn = true
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 32)
                        
                        Spacer(minLength: geometry.size.height * 0.3)
                    }
                }
            }
        }
        // Present Register modally, and on success navigate to home
        .fullScreenCover(isPresented: $goToRegister) {
            Register(onSuccess: {
                goToHome = true
            })
        }
        // Present SignIn modally, and on success navigate to home
        .fullScreenCover(isPresented: $goToSignIn) {
            SignIn(onSuccess: {
                goToHome = true
            })
        }
        // Finally, present the main ContentView and hide its back button
        .fullScreenCover(isPresented: $goToHome) {
            ContentView()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
    }
}
