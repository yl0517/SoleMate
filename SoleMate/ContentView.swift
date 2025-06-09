//  ContentView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showShoeSetup = false
    @State private var activeTab: NavBar.Tab = .home
    @State private var showSavedData = false
    @State private var favoriteShoes: [Shoe] = []
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Brand background
            Color.EEEBE3
                .ignoresSafeArea()
            
            if showShoeSetup {
                // Shoe setup flow
                ShoeSetupFlow(isActive: $showShoeSetup)
                    .background(Color.EEEBE3.ignoresSafeArea())
            } else {
                // Main content
                VStack(spacing: 0) {
                    switch activeTab {
                    case .home:
                        VStack(spacing: 24) {
                            // App icon
                            Image("sole-mate-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Image("sole-mate-logo-text")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                            
                            HStack(spacing: 16) {
                                Button("Set Configurations") {
                                    showShoeSetup = true
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.CA0013)
                                .cornerRadius(12)
                                
                                Button("Current Configurations") {
                                    showSavedData = true
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.CA0013)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal, 40)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    case .search:
                        RecommendationView(
                            isActive: .constant(true),
                            favorites: $favoriteShoes
                        )
                        
                    case .reviews:
                        ReviewView(isActive: .constant(true))
                        
                    case .discussion:
                        DiscussionView()
                        
                    case .saved:
                        FavoritesView()
                    }
                    
                    Spacer()
                    
                    // NavBar
                    NavBar(activeTab: $activeTab)
                        .padding(.bottom, 20)
                }
            }
        }
        .sheet(isPresented: $showSavedData) {
            SavedDataView()
        }
    }
}

struct SavedDataView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.EEEBE3
                    .ignoresSafeArea()
                
                if let config = loadConfig() {
                    List {
                        Section("Activities") {
                            ForEach(config.selectedActivities, id: \.self) { act in
                                Text(act)
                            }
                        }
                        if let other = config.otherActivity, !other.isEmpty {
                            Section("Other Activity") {
                                Text(other)
                            }
                        }
                        Section("Sizing Option") {
                            Text(config.sizingOption.rawValue)
                        }
                        Section("Foot Length") {
                            Text("\(config.footLength, specifier: "%.1f") \(config.footLengthUnit.rawValue)")
                        }
                        Section("Foot Width") {
                            Text("\(config.footWidth, specifier: "%.1f") \(config.footWidthUnit.rawValue)")
                        }
                        Section("Arch Type") {
                            Text(config.archType.rawValue)
                        }
                        Section("Saved At") {
                            Text(DateFormatter.localizedString(
                                from: config.savedAt,
                                dateStyle: .medium,
                                timeStyle: .short
                            ))
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .scrollContentBackground(.hidden)
                } else {
                    Text("No saved configuration")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Current Configurations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
    
    private func loadConfig() -> ShoeConfiguration? {
        UserDefaults.standard.shoeConfiguration
    }
}

#Preview {
    ContentView()
}
