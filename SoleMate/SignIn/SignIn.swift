//
//  SignIn.swift
//  SoleMate
//
//

import SwiftUI
import FirebaseAuth

struct SignIn: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss
    
    let onSuccess: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image("shoes-3")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea().overlay(AppConstants.Colors.backgroundOverlay)
                
                VStack(spacing: 20) {
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left").font(.system(size: 16, weight: .medium))
                                Text("Back")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundColor(Color(.smRed))
                        }
                        
                        Spacer()
                        
                        Text("Sign In")
                            .font(.headline).foregroundColor(Color(.smRed))
                        
                        Spacer()
                            .frame(width: 154)
                    }
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        Image("sole-mate-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.08).padding(.top, 96)
                        
                        Text("Welcome back")
                            .font(.system(size: 16))
                            .foregroundColor(.smBlack)
                    }
                    
                    
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(24)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(24)
                    }
                    .padding(.horizontal, 32)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    
                    Button(action: {
                        signInUser()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "Signing In..." : "Sign In")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: 120)
                        .padding()
                        .background(Color.smRed)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .disabled(isLoading)
                    .padding(.horizontal, 32)
                    
                    Spacer(minLength: geometry.size.height * 0.1)
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarHidden(true)
    }
    
    private func signInUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    dismiss()        // close the fullScreenCover
                    onSuccess()      // tell WelcomeScreen to show home
                }
            }
        }
    }
}
