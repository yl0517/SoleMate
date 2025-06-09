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
            // Background
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
                        // Inline Home UI
                        VStack(spacing: 32) {
                            Text("Temp home screen")
                                .font(.largeTitle)
                                .padding()

                            Button("Set Configurations") {
                                showShoeSetup = true
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                            .padding(.horizontal, 40)

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
                        .padding(.horizontal, 40)

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

                    // Reserve space then draw NavBar
                    Spacer()
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

// MARK: – SavedDataView

struct SavedDataView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                Text(loadRawConfig())
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
            .navigationTitle("Current Configurations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private func loadRawConfig() -> String {
        let key = "ShoeConfigurationKey"
        guard let data = UserDefaults.standard.data(forKey: key),
              let s = String(data: data, encoding: .utf8)
        else { return "No saved configuration" }
        return s
    }
}

// MARK: – Preview

#Preview {
    ContentView()
}
