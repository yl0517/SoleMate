//
//  ShoeSetupFlow.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct ShoeSetupFlow: View {
    @Binding var isActive: Bool
    
    @State private var showStep2 = false
    @State private var showStep3 = false
    
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
    
    @State private var selectedSizing: SizingOption = .women
    @State private var footLengthValue: String = ""
    @State private var footWidthValue: String = ""
    @State private var selectedLengthUnit: LengthUnit = .inches
    @State private var selectedWidthUnit: WidthUnit = .cm
    @State private var selectedArch: ArchType = .flat
    
    var body: some View {
        Step1ActivityView(
            activitySelections: $activitySelections,
            otherActivityText: $otherActivityText,
            showStep2: $showStep2
        )
        .navigationTitle("Activity Type")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showStep2) {
            Step2SizingView(
                selectedSizing: $selectedSizing,
                showStep3: $showStep3
            )
        }
        .navigationDestination(isPresented: $showStep3) {
            Step3MeasurementsView(
                activitySelections: $activitySelections,
                otherActivityText: $otherActivityText,
                selectedSizing: $selectedSizing,
                isActive: $isActive,
                footLengthValue: $footLengthValue,
                footWidthValue: $footWidthValue,
                selectedLengthUnit: $selectedLengthUnit,
                selectedWidthUnit: $selectedWidthUnit,
                selectedArch: $selectedArch,
                showStep2: $showStep2,
                showStep3: $showStep3
            )
        }
        .onChange(of: isActive) { _, newValue in
            if !newValue {
                showStep2 = false
                showStep3 = false
            }
        }
    }
}
