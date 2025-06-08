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

    // Only allow “Save” when both length and width have non-empty values
    private var isFormComplete: Bool {
        !footLengthValue.trimmingCharacters(in: .whitespaces).isEmpty
            && !footWidthValue.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Step header
            Text("Step 3 of 3")
                .font(.headline)

            ProgressView(value: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: .red))

            Text("You’re just a few steps away from finding your perfect pair of shoes")
                .font(.subheadline)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)

            // Foot Length input
            VStack(alignment: .leading, spacing: 8) {
                Text("Foot Length")
                    .fontWeight(.semibold)

                HStack(spacing: 12) {
                    TextField(
                        selectedLengthUnit == .inches ? "inches" : "centimeters",
                        text: $footLengthValue
                    )
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    // two‐parameter onChange to get the new value directly :contentReference[oaicite:0]{index=0}
                    .onChange(of: footLengthValue) { _, newValue in
                        // Filter to digits + at most one decimal point
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        let dots = filtered.filter { $0 == "." }.count
                        if dots <= 1 {
                            footLengthValue = filtered
                        } else {
                            var tmp = filtered
                            if let lastDot = tmp.lastIndex(of: ".") {
                                tmp.remove(at: lastDot)
                            }
                            footLengthValue = tmp
                        }
                    }

                    // in/cm segmented pill
                    unitToggle(for: LengthUnit.allCases, selection: $selectedLengthUnit)
                }
            }

            // Foot Width input
            VStack(alignment: .leading, spacing: 8) {
                Text("Foot Width")
                    .fontWeight(.semibold)

                HStack(spacing: 12) {
                    TextField(
                        selectedWidthUnit == .inches ? "inches" : "centimeters",
                        text: $footWidthValue
                    )
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    // two‐parameter onChange again :contentReference[oaicite:1]{index=1}
                    .onChange(of: footWidthValue) { _, newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        let dots = filtered.filter { $0 == "." }.count
                        if dots <= 1 {
                            footWidthValue = filtered
                        } else {
                            var tmp = filtered
                            if let lastDot = tmp.lastIndex(of: ".") {
                                tmp.remove(at: lastDot)
                            }
                            footWidthValue = tmp
                        }
                    }

                    // in/cm segmented pill
                    unitToggle(for: WidthUnit.allCases, selection: $selectedWidthUnit)
                }
            }

            // Arch Type toggle
            VStack(alignment: .leading, spacing: 8) {
                Text("Arch Type")
                    .fontWeight(.semibold)

                HStack(spacing: 12) {
                    ForEach(ArchType.allCases, id: \.self) { arch in
                        Button {
                            selectedArch = arch
                        } label: {
                            Text(arch.rawValue)
                                .font(.callout)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 24)
                                .background(
                                    selectedArch == arch
                                        ? Color.red
                                        : Color.red.opacity(0.5)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

            Spacer()

            Button {
                isActive = false
            } label: {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .disabled(!isFormComplete)
            .opacity(isFormComplete ? 1 : 0.5)
        }
        .padding()
        .navigationTitle("Foot Measurements")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
        .background(Color.EEEBE3.ignoresSafeArea())
        .onAppear {
            selectedLengthUnit = .inches
            selectedWidthUnit  = .inches
        }
    }

    // Reusable pill-style toggle for “in” / “cm”
    private func unitToggle<T: Hashable & RawRepresentable>(
        for options: [T],
        selection: Binding<T>
    ) -> some View where T.RawValue == String {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { unit in
                Button {
                    selection.wrappedValue = unit
                } label: {
                    Text(unit.rawValue)
                        .font(.callout)
                        .foregroundColor(
                            selection.wrappedValue == unit
                                ? .white
                                : .black
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            selection.wrappedValue == unit
                                ? Color.red
                                : Color.red.opacity(0.3)
                        )
                }
            }
        }
        .clipShape(Capsule())
    }
}

#Preview {
    ContentView()
}
