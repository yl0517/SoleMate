//
//  Register.swift
//  SoleMate
//
//
import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct Register: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss
    
    let onSuccess: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("shoes-2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(AppConstants.Colors.backgroundOverlay)
                
                VStack(spacing: 24) {
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .medium))
                                Text("Back")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundColor(Color(.smRed))
                        }
                        Spacer()
                        Text("Create An Account")
                            .font(.headline)
                            .foregroundColor(Color(.smRed))
                        Spacer().frame(width: 110)
                    }
                    .padding(.horizontal)
                    
                    Image("sole-mate-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * 0.16)
                        .padding(.top, 32)
                    
                    Text("Create an account so you can save your newly discovered shoes in just a few steps")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal, 32)
                    
                    
                    VStack(spacing: 16) {
                        TextField("Name", text: $name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(24)
                        
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
                        registerUser()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "Creating..." : "Create Account")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: 164)
                        .padding()
                        .background(Color(.smRed))
                        .foregroundColor(.white)
                        .cornerRadius(24)
                    }
                    .disabled(isLoading)
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarHidden(true)
    }
    
    func registerUser() {
        errorMessage = ""
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let uid = result?.user.uid else {
                    self.isLoading = false
                    self.errorMessage = "Unexpected error occurred."
                    return
                }
                self.saveUserData(uid: uid)
            }
        }
    }
    
    private func saveUserData(uid: String) {
        let userData: [String: Any] = [
            "id": uid,
            "name": name,
            "email": email,
            "createdAt": Date().timeIntervalSince1970
        ]
        
        let ref = Database.database().reference()
        
        ref.child("users").child(uid).setValue(userData) { error, _ in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    Auth.auth().currentUser?.delete { _ in }
                    self.errorMessage = "Failed to complete registration. Please try again."
                    print("Database error: \(error.localizedDescription)")
                } else {
                    finishRegistration()
                }
            }
        }
    }
    
    private func finishRegistration() {
        dismiss()
        onSuccess()
    }
}
