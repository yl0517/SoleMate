//
//  FavoritesContentView.swift
//  SoleMate
//
//  Created by Jung H Hwang on 6/8/25.
//


// FavoritesContentView.swift
import SwiftUI

struct FavoritesContentView: View {
    @Binding var favorites: [Shoe]

    var body: some View {
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
                        ShoeCardView(shoe: shoe, isFavorite: true) {
                            favorites.removeAll { $0.id == shoe.id }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .padding(.bottom, 140)
            }
        }
    }
}
