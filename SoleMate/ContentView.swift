//
//  ContentView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showShoeSetup = false
    @State private var showRecommendation = false
    
    var body: some View {
        Group {
            if showShoeSetup {
                ShoeSetupFlow(isActive: $showShoeSetup)
                    .background(Color.EEEBE3.ignoresSafeArea())
            } else if showRecommendation {
                RecommendationView(isActive: $showRecommendation)
            } else {
                VStack(spacing: 32) {
                    Text("Temp home screen")
                        .font(.largeTitle)
                        .padding()

                    Button(action: {
                        showShoeSetup = true
                    }) {
                        Text("Set Configurations")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 40)

                    
                    Button(action: {
                        showRecommendation = true
                    }) {
                        Text("Set Recommendations")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.EEEBE3)
            }
        }
        .background(Color.EEEBE3.ignoresSafeArea()) // fallback for Group
    }
}

#Preview {
    ContentView()
}
