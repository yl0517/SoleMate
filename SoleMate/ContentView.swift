//
//  ContentView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showShoeSetup = false
    @State private var activeTab: NavBar.Tab = .home
    
    var body: some View {
        Group {
            if showShoeSetup {
                ShoeSetupFlow(isActive: $showShoeSetup)
                    .background(Color.EEEBE3.ignoresSafeArea())
            } else {
                ZStack(alignment: .bottom) {
                    // Background
                    Color.EEEBE3
                        .ignoresSafeArea()
                    
                    // Main content based on active tab
                    VStack(spacing: 0) {
                        switch activeTab {
                        case .home:
                            VStack(spacing: 32) {
                                Text("Temp home screen")
                                    .font(.largeTitle)
                                    .padding()
                                
                                Button(action: {
                                    showShoeSetup = true
                                }) {
                                    Text("Set Configurations")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.red)
                                        .cornerRadius(8)
                                }
                                .padding(.horizontal, 40)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                        case .search:
                            RecommendationView(isActive: .constant(true))
                            
                        case .reviews:
                            ReviewView(isActive: .constant(true))
                            
                        case .discussion, .saved:
                            // Placeholder views for other tabs
                            VStack {
                                Text("Coming Soon")
                                    .font(.largeTitle)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .padding(.bottom, 80) // Reserve space for NavBar
                    
                    // Navigation Bar pinned to bottom
                    NavBar(activeTab: $activeTab)
                        .padding(.bottom, 20)
                }
            }
        }
        .background(Color.EEEBE3.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
}
