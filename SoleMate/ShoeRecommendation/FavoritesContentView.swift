// FavoritesContentView.swift
import SwiftUI

struct FavoritesContentView: View {
    let shoes: [Shoe]
    let onToggle: (Shoe) -> Void
    @State private var selectedForReview: Shoe?

    var body: some View {
        if shoes.isEmpty {
            Spacer()
            Text("You haven't saved any shoes yet.")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            Spacer()
        } else {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(shoes) { shoe in
                        ShoeCardView(
                            shoe: shoe,
                            isFavorite: true,
                            onFavoriteToggle: { onToggle(shoe) },
                            onReview: { selectedForReview = shoe }
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .padding(.bottom, 140)
            }
            .sheet(item: $selectedForReview) { shoe in
                ReviewInputView(shoe: shoe)
            }
        }
    }
}
