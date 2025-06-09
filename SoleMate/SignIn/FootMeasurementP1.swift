
import SwiftUI

struct FootMeasurementsP1: View {
    @State private var footLength = ""
    @State private var footWidth = ""
    @State private var selectedLengthUnit = "in"
    @State private var selectedWidthUnit = "cm"
    @State private var selectedArchType: String? = nil
    @State private var navigateToP2 = false
    @Environment(\.dismiss) private var dismiss
    
    let archOptions = ["Flat", "Medium", "High"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                progressSection
                logoAndDescriptionSection(geometry: geometry)
                footLengthSection
                footWidthSection
                archTypeSection
                continueButtonSection
            }
            .padding(.top)
        }
        .background(Color.background)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToP2) {
            FootMeasurementsP2(
                footLength: footLength,
                footWidth: footWidth,
                lengthUnit: selectedLengthUnit,
                widthUnit: selectedWidthUnit,
                archType: selectedArchType ?? ""
            )
        }
    }
    
    private var headerSection: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left").font(.system(size: 16, weight: .medium))
                    Text("Back")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(Color(.smRed))
            }

            Spacer()
            
            Text("Foot Measurements")
                .font(.headline).foregroundColor(Color(.smRed))
            
            Spacer()
                .frame(width: 100)
        }
        .padding(.horizontal)
    }
    
    private var progressSection: some View {
        SoleMateLogo.ProgressBar(current: 1, total: 2)
            .padding(.horizontal)
    }
    
    private func logoAndDescriptionSection(geometry: GeometryProxy) -> some View {
        VStack {
            Image("sole-mate-logo")
                .resizable()
                .scaledToFit()
                .frame(height: geometry.size.height * 0.1)
                .padding(.top,8)
                .frame(maxWidth: .infinity)
            Text("You're just a few steps away from finding your perfect pair of shoes")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private var footLengthSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Foot Length")
            HStack {
                TextField("Inches", text: $footLength)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                SoleMateLogo.UnitToggle(selectedUnit: $selectedLengthUnit, options: ["in", "cm"])
            }
        }
        .padding(.horizontal)
    }
    
    private var footWidthSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Foot Width")
            HStack {
                TextField("Centimeters", text: $footWidth)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                SoleMateLogo.UnitToggle(selectedUnit: $selectedWidthUnit, options: ["in", "cm"])
            }
        }
        .padding(.horizontal)
    }
    
    private var archTypeSection: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Arch Type")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 12) {
                ForEach(archOptions, id: \.self) { option in
                    SoleMateLogo.ArchTypeButton(
                        title: option,
                        isSelected: selectedArchType == option
                    ) {
                        selectedArchType = option
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
    
    private var continueButtonSection: some View {
        SoleMateLogo.PrimaryButton(title: "Continue") {
            navigateToP2 = true
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
}

#Preview {
    FootMeasurementsP1()
}
