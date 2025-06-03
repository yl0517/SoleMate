//
//  ContentView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var showShoeSetup = false

    var body: some View {
        Group {
            if showShoeSetup {
                ShoeSetupFlow(isActive: $showShoeSetup)
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

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            }
        }
    }
}


#Preview {
    ContentView()
}
