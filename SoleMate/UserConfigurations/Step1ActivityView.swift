//
//  Step1ActivityView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct Step1ActivityView: View {
    @Binding var activitySelections: [String: Bool]
    @Binding var otherActivityText: String
    @Binding var showStep2: Bool
    
    private let activityOrder: [String] = [
        "Running",
        "Walking",
        "Weightlifting",
        "Work",
        "Hiking",
        "Casual Wear",
        "Other"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Step label + progress bar
            Text("Step 1 of 3")
                .font(.headline)
            
            ProgressView(value: 0.33333333)
                .progressViewStyle(LinearProgressViewStyle(tint: .red))
            
            Text("What will you be using these shoes for?")
                .font(.subheadline)
            
            // Activity options
            ForEach(activityOrder, id: \.self) { key in
                VStack(alignment: .leading, spacing: 4) {
                    Button(action: {
                        activitySelections[key] = !(activitySelections[key] ?? false)
                    }) {
                        HStack {
                            Image(systemName: activitySelections[key] == true ? "checkmark.square.fill" : "square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                            
                            Text(key == "Other" ? "Other (Specify)" : key)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                        )
                        .cornerRadius(12)
                    }
                    
                    if key == "Other", activitySelections["Other"] == true {
                        TextField("Specify activity…", text: $otherActivityText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 12)
                    }
                }
            }
            
            Spacer()
            
           
            Button(action: {
                showStep2 = true
            }) {
                Text("Next")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .disabled(!atLeastOneActivitySelected())
        }
        .padding()
        .background(Color.EEEBE3.ignoresSafeArea())
    }
    
    private func atLeastOneActivitySelected() -> Bool {
        return activitySelections.values.contains(true)
    }
}

#Preview {
    ContentView()
}
