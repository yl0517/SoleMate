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
    @State private var favoriteShoes: [Shoe] = []    // track saved shoes

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

                                // Start configuration flow
                                Button("Set Configurations") {
                                    showShoeSetup = true
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                                .padding(.horizontal, 40)

                                // Debug: view raw saved data
                                Button("View User Saved Data") {
                                    showSavedData = true
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                                .padding(.horizontal, 40)

                                Spacer()
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
                            VStack {
                                Text("Discussion")
                                    .font(.largeTitle)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        case .saved:
                            FavoritesView(favorites: $favoriteShoes)
                        }
                    }
                    .padding(.bottom, 80) // Reserve space for NavBar

                    // Navigation Bar pinned to bottom
                    NavBar(activeTab: $activeTab)
                        .padding(.bottom, 20)
                }
            }
        }
        // Sheet to display raw JSON stored in UserDefaults
        .sheet(isPresented: $showSavedData) {
            SavedDataView()
        }
        .background(Color.EEEBE3.ignoresSafeArea())
    }
}

struct SavedDataView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                Text(rawJsonString())
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
            .navigationTitle("Saved Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private func rawJsonString() -> String {
        let key = "ShoeConfigurationKey"
        guard let data = UserDefaults.standard.data(forKey: key),
              let json = String(data: data, encoding: .utf8) else {
            return "No saved configuration"
        }
        return json
    }
}

#Preview {
    ContentView()
}
