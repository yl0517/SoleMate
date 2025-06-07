//
//  SignIn.swift
//  SoleMate
//
//

import SwiftUI

struct SignIn: View{
    @State private var email = ""
    @State private var password = ""
    
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
                    
             
                    Button(action: {
            
                    }) {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .frame(maxWidth: 64)
                            .padding()
                            .background(Color.smRed)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer(minLength: geometry.size.height * 0.1)
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview{
    SignIn()
}
