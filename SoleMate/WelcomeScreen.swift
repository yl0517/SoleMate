//
//  WelcomeScreen.swift
//  SoleMate
//
//  Created by Carlos Carrillo-Sandoval on 5/23/25.
//

import SwiftUI

struct WelcomeScreen: View {
    @State private var goToRegister = false
    @State private var goToSignIn = false
    @State private var goToHome = false

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
                            Button(action: {
                                goToRegister = true
                            }) {
                                Text("Create Account")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: 148)
                                    .padding()
                                    .background(Color.smRed)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }

                            Button(action: {
                                goToHome = true
                            }) {
                                Text("Continue As Guest")
                                    .underline()
                                    .foregroundColor(.primary)
                            }

                            Text("Already have an account?")
                                .font(.system(size: 12))

                            Button(action: {
                                goToSignIn = true
                            }) {
                                Text("Sign In")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(.top, 4)
                            }
                        }
                        .padding(.horizontal, 32)

                        Spacer(minLength: geometry.size.height * 0.3)
                    }
                }
            }
            .navigationDestination(isPresented: $goToRegister) {
                Register()
            }
            .navigationDestination(isPresented: $goToSignIn) {
                SignIn()
            }
            .navigationDestination(isPresented: $goToHome) {
                Home()
            }
        }
    }
}

#Preview {
    WelcomeScreen()
}
