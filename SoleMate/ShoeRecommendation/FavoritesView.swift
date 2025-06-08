// FavoritesView.swift
// SoleMate

import SwiftUI

struct FavoritesView: View {
    @Binding var favorites: [Shoe]

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "SAVED")
            FavoritesContentView(favorites: $favorites)
        }
    }
}
