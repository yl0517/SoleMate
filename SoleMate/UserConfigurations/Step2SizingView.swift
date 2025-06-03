//
//  Step2SizingView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct Step2SizingView: View {
    @Binding var selectedSizing: SizingOption

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Step 2 of 3")
                .font(.headline)

            Text("Which sizing are you most familiar with?")
                .font(.subheadline)

            Text("""
            This helps us show you shoes in the right size range and fit. Shoe construction varies by sizing system
            """)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.secondary)

            ForEach(SizingOption.allCases, id: \.self) { option in
                Button(action: {
                    selectedSizing = option
                }) {
                    HStack {
                        Image(systemName: iconName(for: option))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .cornerRadius(4)
                            .padding(.trailing, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(option.rawValue)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(tooltip(for: option))
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.9))
                        }

                        Spacer()

                        if selectedSizing == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding()
                    .background(
                        selectedSizing == option
                        ? Color.red
                        : Color(UIColor.systemGray5)
                    )
                    .cornerRadius(8)
                }
            }

            Spacer()
            
            Text("""
            We'll use your foot measurements to find the best fit regardless of sizing system
            """)

            NavigationLink(value: 3) {
                Text("Next")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Sizing System")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func iconName(for option: SizingOption) -> String {
        switch option {
        case .women: return "figure.walk"
        case .men:   return "figure.stand"
        case .both:  return "figure.wave"
        }
    }

    private func tooltip(for option: SizingOption) -> String {
        switch option {
        case .women: return "Typically narrower fit. Women’s 8 = Men’s 6.5"
        case .men:   return "Typically wider fit. Men’s 9 = Women’s 10.5"
        case .both:  return "Show me options in both sizing systems"
        }
    }
}


#Preview {
    ContentView()
}
