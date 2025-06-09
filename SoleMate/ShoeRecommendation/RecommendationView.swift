// RecommendationView.swift
import SwiftUI

struct RecommendationView: View {
    @Binding var isActive: Bool
    @Binding var favorites: [Shoe]

    @State private var shoes: [Shoe] = []

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "SOLE MATE")
            RecommendationContentView(shoes: shoes, favorites: $favorites)
        }
        .background(Color.EEEBE3.ignoresSafeArea())
        .onAppear(perform: loadShoes)
    }

    private func loadShoes() {
        guard let url = Bundle.main.url(forResource: "mock_shoes", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Shoe].self, from: data)
        else {
            print("Failed to load mock_shoes.json")
            return
        }
        shoes = decoded
    }
}
