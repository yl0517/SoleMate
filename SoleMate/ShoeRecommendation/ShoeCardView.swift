import SwiftUI

struct ShoeCardView: View {
    let shoe: Shoe
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    let onReview: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.FCFBF9)
                .frame(height: 136)
                .shadow(color: Color.black.opacity(0.07), radius: 80, x: 0, y: 22)
                .shadow(color: Color.black.opacity(0.042), radius: 22, x: 0, y: 6)
            
            HStack(spacing: 0) {
                // Fixed-size placeholder for image
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(width: 124, height: 124)
                .padding(.leading, 6)
                .padding(.vertical, 6)
                

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(shoe.name)
                            .padding(.leading, 6)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.CA0013)
                    }
                    
                    Text("$\(shoe.price, specifier: "%.2f")")
                        .padding(.leading, 6)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color.textDark)
                }
                .padding(.vertical, 6)
                .padding(.trailing, 12)
                
                Spacer()
            }
            .frame(height: 136)
        }
        .frame(maxWidth: .infinity, minHeight: 136)
        .overlay(
            Button(action: onFavoriteToggle) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 20))
                    .padding(10)
                    .foregroundColor(isFavorite ? .red : Color.CA0013)
            }, alignment: .topTrailing
        )
        .overlay(
            Button(action: onReview) {
                Text("Review")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.CA0013.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(10), alignment: .bottomTrailing
        )
    }
}
