// FavoritesView.swift
import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct FavoritesView: View {
    @StateObject private var repo = FirebaseFavoritesRepository()

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "SAVED")
            FavoritesContentView(
                shoes: repo.favorites,
                onToggle: repo.toggleFavorite(_:)
            )
        }
        .background(Color.EEEBE3.ignoresSafeArea())
    }
}
