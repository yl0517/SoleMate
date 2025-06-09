// RecommendationContentView.swift
import SwiftUI

struct RecommendationContentView: View {
    let shoes: [Shoe]
    @Binding var favorites: [Shoe]
    @State private var selectedCategory: Category = .running
    @State private var selectedShoeForReview: Shoe?
    
    enum Category: String, CaseIterable {
        case running = "Running"
        case walking = "Walking"
        case weightlifting = "Weightlifting"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Category pills
            HStack(spacing: 12) {
                ForEach(Category.allCases, id: \.self) { cat in
                    Text(cat.rawValue)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(selectedCategory == cat ? Color.FBFAF8 : Color.CA0013)
                        .frame(height: 26)
                        .frame(minWidth: cat == .weightlifting ? 80 : (cat == .running ? 57 : 55))
                        .padding(.horizontal, 8)
                        .background(selectedCategory == cat ? Color.CA0013 : Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.CA0013, lineWidth: 1))
                        .cornerRadius(12)
                        .onTapGesture { selectedCategory = cat }
                }
                Spacer()
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 24))
                    .foregroundColor(Color.CA0013)
                    .padding(.trailing, 24)
            }
            .padding(.leading, 24)
            .padding(.top, 16)
            
            // Compare button
            HStack {
                Button(action: {}) {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.left.and.right")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.CA0013)
                        Text("Compare Shoes")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.CA0013)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(Color.FCFBF9)
                    .cornerRadius(16)
                }
                .padding(.leading, 24)
                Spacer()
            }
            .padding(.top, 16)
            
            // Shoe list
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(shoes) { shoe in
                        ShoeCardView(
                            shoe: shoe,
                            isFavorite: favorites.contains(shoe),
                            onFavoriteToggle: {
                                if let idx = favorites.firstIndex(of: shoe) {
                                    favorites.remove(at: idx)
                                } else {
                                    favorites.append(shoe)
                                }
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
        .sheet(item: $selectedShoeForReview) { shoe in
            ReviewInputView(shoe: shoe)
        }
    }
}
