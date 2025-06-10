//  ContentView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showShoeSetup = false
    @State private var activeTab: NavBar.Tab = .home
    @State private var showSavedData = false
    @State private var favoriteShoes: [Shoe] = []

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.EEEBE3
                .ignoresSafeArea()

            VStack(spacing: 0) {
                switch activeTab {
                case .home:
                    VStack(spacing: 24) {
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

                        // New button to return to WelcomeScreen
                        Button("Back to Welcome") {
                            dismiss()
                        }
                        .font(.headline)
                        .foregroundColor(Color.CA0013)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .search:
                    RecommendationView(isActive: .constant(true), favorites: $favoriteShoes)

                case .discussion:
                    DiscussionView()

                case .saved:
                    FavoritesView()

                case .reviews:
                    ReviewView(isActive: .constant(true))
                }

                NavBar(activeTab: $activeTab)
                    .padding(.bottom, 20)
            }
        }
        .fullScreenCover(isPresented: $showShoeSetup) {
            ShoeSetupFlow(isActive: $showShoeSetup)
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
