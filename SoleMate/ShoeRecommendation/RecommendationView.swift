// RecommendationView.swift
// SoleMate
//
// Updated to use NavBar for a floating bottom navigation.

import SwiftUI

struct RecommendationView: View {
    @Binding var isActive: Bool

    // MARK: – MOCK MODEL for preview
    struct Shoe: Identifiable {
        let id = UUID()
        let name: String
        let price: String
        let description: String
        let imageName: String
    }

    let shoes: [Shoe] = [
        .init(name: "Nike Air Max 90", price: "$113.89",
              description: "Classic style with modern cushioning technology.",
              imageName: "shoe1"),
        .init(name: "Vans Old Skool", price: "$59.99",
              description: "Timeless skate silhouette in canvas and suede.",
              imageName: "shoe2"),
        .init(name: "New Balance 574", price: "$89.95",
              description: "Retro running style with ENCAP cushioning.",
              imageName: "shoe3"),
        .init(name: "Converse Chuck Taylor", price: "$49.99",
              description: "Iconic canvas sneaker with high-top design.",
              imageName: "shoe4"),
        .init(name: "Nike Air Force 1", price: "$99.99",
              description: "Leather construction with encapsulated Air unit.",
              imageName: "shoe5")
    ]

    // MARK: – STATE
    @State private var selectedCategory: Category = .running
    @State private var activeTab: NavBar.Tab = .search  // Adjusted to NavBar.Tab

    enum Category: String, CaseIterable {
        case running = "Running"
        case walking = "Walking"
        case weightlifting = "Weightlifting"
    }

    var body: some View {
        ZStack {
            // Background
            Color.EEEBE3
                .ignoresSafeArea()

            // Main content
            VStack(spacing: 0) {
                headerView
                categoryPills
                compareButton

                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(shoes) { shoe in
                            ShoeCardView(shoe: shoe)
                        }
                        .padding(.top, 16)
                    }
                    .padding(.horizontal, 24)
                    // Reserve space so last card isn't hidden behind the bar
                    .padding(.bottom, 140)
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: – Header View
    private var headerView: some View {
        ZStack {
            Color.white
                .frame(height: 84)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

            HStack {
                Button(action: { isActive = false }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.CA0013)
                }
                .padding(.leading, 24)

                Spacer()

                Text("SOLE MATE")
                    .font(.custom("Bagel Fat One", size: 24))
                    .foregroundColor(Color.CA0013)
                    .kerning(-1)

                Spacer()

                Image(systemName: "bell")
                    .font(.system(size: 20))
                    .foregroundColor(Color.CA0013)
                    .padding(.trailing, 24)
            }
            .frame(height: 84)
        }
    }

    // MARK: – Category Pills
    private var categoryPills: some View {
        HStack(spacing: 12) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(selectedCategory == category ? Color.FBFAF8 : Color.CA0013)
                    .frame(height: 26)
                    .frame(minWidth: category == .weightlifting ? 80 : (category == .running ? 57 : 55))
                    .padding(.horizontal, 8)
                    .background(
                        selectedCategory == category ? Color.CA0013 : Color.clear
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.CA0013, lineWidth: 1)
                    )
                    .cornerRadius(12)
                    .onTapGesture { selectedCategory = category }
            }
            Spacer()
            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 24))
                .foregroundColor(Color.CA0013)
                .padding(.trailing, 24)
        }
        .padding(.leading, 24)
        .padding(.top, 16)
    }

    // MARK: – Compare Shoes Button
    private var compareButton: some View {
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
    }
}

// MARK: – ShoeCardView

private struct ShoeCardView: View {
    let shoe: RecommendationView.Shoe
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.FCFBF9)
                .frame(height: 136)
                .shadow(color: Color.black.opacity(0.07), radius: 80, x: 0, y: 22)
                .shadow(color: Color.black.opacity(0.0417), radius: 22.3363, x: 0, y: 6.6501)

            HStack(spacing: 12) {
                Image(shoe.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 124, height: 124)
                    .clipped()
                    .cornerRadius(16)
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
                    .frame(height: 23)

                    Text(shoe.price)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color.textDark)

                    Text(shoe.description)
                        .font(.system(size: 12))
                        .foregroundColor(Color.textDark)
                        .lineLimit(3)
                        .frame(height: 68)
                }
                .padding(.vertical, 6)
                .padding(.trailing, 8)
            }
            .frame(height: 136)
        }
        .frame(height: 136)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RecommendationView(isActive: .constant(true))
}
