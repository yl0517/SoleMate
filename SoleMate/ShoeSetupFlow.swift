//
//  ShoeSetupFlow.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct ShoeSetupFlow: View {
    // Binding back to ContentView; when this becomes false, the flow ends
    @Binding var isActive: Bool

    // Step 1 state
    @State private var activitySelections: [String: Bool] = [
        "Running": false,
        "Walking": false,
        "Weightlifting": false,
        "Work": false,
        "Hiking": false,
        "Casual Wear": false,
        "Other": false
    ]
    @State private var otherActivityText: String = ""

    // Step 2 state
    @State private var selectedSizing: SizingOption = .women

    // Step 3 state
    @State private var footLengthValue: String = ""
    @State private var footWidthValue: String = ""
    @State private var selectedLengthUnit: LengthUnit = .inches
    @State private var selectedWidthUnit: WidthUnit  = .cm
    @State private var selectedArch: ArchType         = .flat

    var body: some View {
        NavigationStack {
            // Start on Step 1
            Step1ActivityView(
                activitySelections: $activitySelections,
                otherActivityText:  $otherActivityText
            )
            .navigationDestination(for: Int.self) { step in
                switch step {
                case 2:
                    // Push Step 2
                    Step2SizingView(selectedSizing: $selectedSizing)
                case 3:
                    // Push Step 3
                    Step3MeasurementsView(
                        isActive:           $isActive,
                        footLengthValue:    $footLengthValue,
                        footWidthValue:     $footWidthValue,
                        selectedLengthUnit: $selectedLengthUnit,
                        selectedWidthUnit:  $selectedWidthUnit,
                        selectedArch:       $selectedArch
                    )
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Activity Type")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}
