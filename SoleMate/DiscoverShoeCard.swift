//
//  DiscoverShoeCard.swift
//  SoleMate
//
//  Created by Carlos Carrillo-Sandoval on 6/6/25.
//

import SwiftUI

enum ShoeCardSize {
    case large
    case small
}

struct DiscoverShoeCard: View {
    let imageName: String
    let title: String
    let size: ShoeCardSize

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    width: size == .large ? 320 : 150,
                    height: size == .large ? 180 : 120
                )
                .clipped()
                .cornerRadius(16)

            if size == .large {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(.smRed))
                    .padding(.leading, 4)
            } else {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color(.smRed))
                    .lineLimit(1)
                    .padding(.horizontal, 4)
            }
        }
        .frame(maxWidth: size == .large ? .infinity : 160)
        .padding(size == .large ? 0 : 4).background(Color(.lightBackground)).cornerRadius(20).padding(.vertical, size == .large ? 8 : 12)
        .padding(.horizontal, size == .large ? 4 : 8)
    }
}
