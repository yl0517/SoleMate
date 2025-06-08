// RecommendationView.swift
import SwiftUI

struct RecommendationView: View {
    @Binding var isActive: Bool
    @Binding var favorites: [Shoe]   // <- binding passed from ContentView

    let shoes: [Shoe] = [
        .init(name: "Nike Air Max 90", price: "$113.89", description: "Classic style with modern cushioning technology.", imageName: "shoe1"),
        .init(name: "Vans Old Skool", price: "$59.99", description: "Timeless skate silhouette in canvas and suede.", imageName: "shoe2"),
        .init(name: "New Balance 574", price: "$89.95", description: "Retro running style with ENCAP cushioning.", imageName: "shoe3"),
        .init(name: "Converse Chuck Taylor", price: "$49.99", description: "Iconic canvas sneaker with high-top design.", imageName: "shoe4"),
        .init(name: "Nike Air Force 1", price: "$99.99", description: "Leather construction with encapsulated Air unit.", imageName: "shoe5")
    ]

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "SOLE MATE")
            // pass the binding directly to the content view:
            RecommendationContentView(shoes: shoes, favorites: $favorites)
        }
        .background(Color.EEEBE3.ignoresSafeArea())
    }
}
