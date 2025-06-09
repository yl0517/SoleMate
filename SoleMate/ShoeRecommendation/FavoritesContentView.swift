//
//  FavoritesContentView.swift
//  SoleMate
//
//  Created by Jung H Hwang on 6/8/25.
//

import SwiftUI

struct FavoritesContentView: View {
    @Binding var favorites: [Shoe]
    @State private var selectedShoeForReview: Shoe?

    var body: some View {
        Group {
            if favorites.isEmpty {
                Spacer()
                Text("You haven't saved any shoes yet.")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(favorites) { shoe in
                            ShoeCardView(
                                shoe: shoe,
                                isFavorite: true,
                                onFavoriteToggle: {
                                    favorites.removeAll { $0.id == shoe.id }
                                },
                                onReview: {
                                    selectedShoeForReview = shoe
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .padding(.bottom, 140)
                }
            }
        }
        .sheet(item: $selectedShoeForReview) { shoe in
            ReviewInputView(shoe: shoe)
        }
    }
}
