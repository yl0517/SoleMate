//
//  Step3MeasurementsView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct Step3MeasurementsView: View {
    @Binding var isActive: Bool

    @Binding var footLengthValue:  String
    @Binding var footWidthValue:   String
    @Binding var selectedLengthUnit: LengthUnit
    @Binding var selectedWidthUnit:  WidthUnit
    @Binding var selectedArch:       ArchType

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Step 3 of 3")
                .font(.headline)

            Text("You’re just a few steps away from finding your perfect pair of shoes")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            // Foot Length
            VStack(alignment: .leading, spacing: 4) {
                Text("Foot Length")
                    .font(.callout)
                HStack {
                    TextField("Enter value", text: $footLengthValue)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Picker("", selection: $selectedLengthUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100)
                }
            }

            // Foot Width
            VStack(alignment: .leading, spacing: 4) {
                Text("Foot Width")
                    .font(.callout)
                HStack {
                    TextField("Enter value", text: $footWidthValue)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Picker("", selection: $selectedWidthUnit) {
                        ForEach(WidthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100)
                }
            }

            // Arch Type
            VStack(alignment: .leading, spacing: 8) {
                Text("Arch Type")
                    .font(.callout)

                HStack {
                    ForEach(ArchType.allCases, id: \.self) { arch in
                        Button(action: {
                            selectedArch = arch
                        }) {
                            Text(arch.rawValue)
                                .foregroundColor(
                                    selectedArch == arch
                                    ? .white
                                    : .primary
                                )
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    selectedArch == arch
                                    ? Color.red
                                    : Color(UIColor.systemGray5)
                                )
                                .cornerRadius(8)
                        }
                    }
                }
            }

            Spacer()

            // “Continue” ends the flow and returns to home screen
            Button(action: {
                isActive = false
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Foot Measurements")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Hide the “Back” button so user can’t go backward after finishing
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
    }
}
