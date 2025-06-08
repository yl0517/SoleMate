//
//  ShoeSetupFlow.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import SwiftUI

struct ShoeSetupFlow: View {
    @Binding var isActive: Bool
    
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
    
    init(isActive: Binding<Bool>) {
        self._isActive = isActive
        
        // Customize navigation title color to red
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            Step1ActivityView(
                activitySelections: $activitySelections,
                otherActivityText:  $otherActivityText
            )
            .navigationDestination(for: Int.self) { step in
                switch step {
                case 2:
                    Step2SizingView(selectedSizing: $selectedSizing)
                case 3:
                    Step3MeasurementsView(
                        // New bindings:
                        activitySelections: $activitySelections,
                        otherActivityText:  $otherActivityText,
                        selectedSizing:     $selectedSizing,
                        // Existing bindings:
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
