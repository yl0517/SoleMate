//
//  Step1ActivityView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct Step1ActivityView: View {
    @Binding var activitySelections: [String: Bool]
    @Binding var otherActivityText:  String

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
            Text("Step 1 of 3")
                .font(.headline)

            Text("What will you be using these shoes for?")
                .font(.subheadline)

            ForEach(activityOrder, id: \.self) { key in
                if key == "Other" {
                    VStack(alignment: .leading, spacing: 4) {
                        Toggle(isOn: Binding(
                            get: { activitySelections["Other"] ?? false },
                            set: { activitySelections["Other"] = $0 }
                        )) {
                            Text("Other (Specify)")
                        }
                        .toggleStyle(.button)
                        .tint(Color.red)

                        if activitySelections["Other"] == true {
                            TextField("Specify activity…", text: $otherActivityText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading, 24)
                        }
                    }
                } else {
                    Toggle(isOn: Binding(
                        get: { activitySelections[key] ?? false },
                        set: { activitySelections[key] = $0 }
                    )) {
                        Text(key)
                    }
                    .toggleStyle(.button)
                    .tint(Color.red.opacity(0.8))
                }
            }

            Spacer()

            NavigationLink(value: 2) {
                Text("Next")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .disabled(!atLeastOneActivitySelected())
        }
        .padding()
    }

    private func atLeastOneActivitySelected() -> Bool {
        return activitySelections.values.contains(true)
    }
}
