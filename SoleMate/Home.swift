//
//  Home.swift
//  SoleMate
//
//  Created by Carlos Carrillo-Sandoval on 6/6/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image("sole-mate-logo-text")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)

                    Spacer()

                    Image("profile-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                .padding(.horizontal)

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Discover")
                            .font(.title).bold()
                            .foregroundColor(Color(.smRed))

                        Text("The right fit for your feet, the right step for your health")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color.lightBackground) 

                DiscoverShoeCard(
                    imageName: "shoe-card-temp-1",
                    title: "Top Running Shoes",
                    size: .large
                )
                .padding(.horizontal)

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 16
                ) {
                    DiscoverShoeCard(imageName: "shoe-card-temp-2", title: "Walking Shoes", size: .small)
                    DiscoverShoeCard(imageName: "shoe-card-temp-3", title: "Work Shoes", size: .small)
                    DiscoverShoeCard(imageName: "shoe-card-temp-4", title: "Hiking Shoes", size: .small)
                    DiscoverShoeCard(imageName: "shoe-card-temp-5", title: "Sneakers", size: .small)
                    DiscoverShoeCard(imageName: "shoe-card-temp-6", title: "Training Shoes", size: .small)
                    DiscoverShoeCard(imageName: "shoe-card-temp-7", title: "Trail Runners", size: .small)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.background)
    }
}

#Preview {
    Home()
}
