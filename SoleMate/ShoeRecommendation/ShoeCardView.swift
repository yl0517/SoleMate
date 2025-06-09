// ShoeCardView.swift
import SwiftUI

struct ShoeCardView: View {
    let shoe: Shoe
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.FCFBF9)
                .frame(height: 136)
                .shadow(color: Color.black.opacity(0.07), radius: 80, x: 0, y: 22)
                .shadow(color: Color.black.opacity(0.042), radius: 22, x: 0, y: 6)

            HStack(spacing: 12) {
                // placeholder in place of real image:
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 124, height: 124)
                    .padding(.leading, 8)
                    .padding(.vertical, 6)

                Rectangle()
                    .fill(Color.EEEBE3)
                    .frame(width: 1, height: 124)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(shoe.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.CA0013)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.CA0013)
                    }

                    // price/description are empty stubs for now
                    Text(shoe.price)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color.textDark)

                    Text(shoe.description)
                        .font(.system(size: 12))
                        .foregroundColor(Color.textDark)
                        .lineLimit(3)
                }
                .padding(.vertical, 6)
                .padding(.trailing, 8)
            }
            .frame(height: 136)

            Button(action: onFavoriteToggle) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 20))
                    .padding(10)
                    .foregroundColor(isFavorite ? .red : Color.CA0013)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 136)
    }
}
