//
//  HeaderView.swift
//  SoleMate
//
//  Created by Jung H Hwang on 6/8/25.
//


// HeaderView.swift
import SwiftUI

struct HeaderView: View {
    let title: String

    var body: some View {
        ZStack {
            Color.white
                .frame(height: 84)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

            HStack {
                Spacer()
                Text(title)
                    .font(.custom("Bagel Fat One", size: 24))
                    .foregroundColor(Color.CA0013)
                    .kerning(-1)
                Spacer()
            }
        }
    }
}