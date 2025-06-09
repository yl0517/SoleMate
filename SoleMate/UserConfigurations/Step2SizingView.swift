//
//  Step2SizingView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct Step2SizingView: View {
    @Binding var selectedSizing: SizingOption
    @Binding var showStep3: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Step label + progress bar
            Text("Step 2 of 3")
                .font(.headline)
            
            ProgressView(value: 0.6666667)
                .progressViewStyle(LinearProgressViewStyle(tint: .red))
            
            Text("Which sizing are you most familiar with?")
                .font(.subheadline)
                .bold()
            
            Text("""
            This helps us show you shoes in the right size range and fit. Shoe construction varies by sizing system
            """)
            .font(.footnote)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            
            // Sizing cards
            ForEach(SizingOption.allCases, id: \.self) { option in
                Button(action: {
                    selectedSizing = option
                }) {
                    HStack(spacing: 12) {
                        // Icon
                        Image(systemName: iconName(for: option))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding(4)
                        
                        // Vertical divider
                        Rectangle()
                            .frame(width: 2)
                            .foregroundColor(selectedSizing == option ? .white : Color.EEEBE3)
                            .padding(.trailing, -6)
                        
                        // Texts
                        VStack(alignment: .leading, spacing: 4) {
                            Text(option.rawValue)
                                .font(.body)
                                .foregroundColor(selectedSizing == option ? .white : .red)
                            
                            Text(tooltip(for: option))
                                .font(.caption2)
                                .foregroundColor(selectedSizing == option ? .white.opacity(0.9) : .black)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(
                        selectedSizing == option
                        ? Color.red
                        : Color.FCFBF9
                    )
                    .cornerRadius(12)
                }
            }
            
            Spacer()
            
            Text("We'll use your foot measurements to find the best fit regardless of sizing system")
                .font(.footnote)
                .foregroundColor(.primary)
            
            
            Button(action: {
                showStep3 = true
            }) {
                Text("Next")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
            }
        }
        .padding()
        .navigationTitle("Foot Measurements")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.EEEBE3.ignoresSafeArea())
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
        case .women:
            return "Typically narrower fit. Women's 8 = Men's 6.5"
        case .men:
            return "Typically wider fit. Men's 9 = Women's 10.5"
        case .both:
            return "Show me options in both sizing systems"
        }
    }
}

#Preview {
    ContentView()
}
