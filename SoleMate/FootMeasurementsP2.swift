//
//  FootMeasurementsP2.swift
//  SoleMate
//

import SwiftUI

struct FootMeasurementsP2: View {
    @State private var selectedSizing: String? = nil

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left").font(.system(size: 16, weight: .medium))
                            Text("Back")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(Color(.smRed))
                    }

                    Spacer()

                    Text("Foot Measurements")
                        .font(.headline).foregroundColor(Color(.smRed))

                    Spacer()
                        .frame(width: 100)
                }
                .padding(.horizontal)


                SoleMateLogo.ProgressBar(current: 2, total: 2)
                    .padding(.horizontal)

                Image("sole-mate-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * 0.1)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Which sizing are you most familiar with?")
                        .font(.headline)
                    Text("This helps us show you shoes in the right size range and fit. Shoe construction varies by sizing system.")
                        .font(.subheadline)
                        .foregroundColor(.smBlack).multilineTextAlignment(.leading).lineLimit(nil).fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    SizingCard(
                        title: "Women’s sizing",
                        subtitle: "Typically narrower fit\nWomen’s 8 = Men’s 6.5",
                        imageName: "womens-shoe-sizing",
                        isSelected: selectedSizing == "Women"
                    ) {
                        selectedSizing = "Women"
                    }

                    SizingCard(
                        title: "Men’s sizing",
                        subtitle: "Typically wider fit\nMen’s 9 = Women’s 10.5",
                        imageName: "mens-shoe-sizing",
                        isSelected: selectedSizing == "Men"
                    ) {
                        selectedSizing = "Men"
                    }

                    SizingCard(
                        title: "Both/Either",
                        subtitle: "Show me options in both sizing systems",
                        imageName: "both-shoe-sizing",
                        isSelected: selectedSizing == "Both"
                    ) {
                        selectedSizing = "Both"
                    }
                }
                .padding(.horizontal)
                
                Text("This helps us show you shoes in the right size range and fit. Shoe construction varies by sizing system.")
                    .font(.subheadline)
                    .foregroundColor(.smBlack).padding(.horizontal).multilineTextAlignment(.leading).lineLimit(nil).fixedSize(horizontal: false, vertical: true)

                Spacer()

                SoleMateLogo.PrimaryButton(title: "Save") {
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                
            }
            .padding(.top)
        }
        .background(Color.background)
    }
}

#Preview {
    FootMeasurementsP2()
}

