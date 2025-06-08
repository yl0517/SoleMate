//
//  FootMeasurementsP2.swift
//  SoleMate
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct FootMeasurementsP2: View {
    let footLength: String
    let footWidth: String
    let lengthUnit: String
    let widthUnit: String
    let archType: String
    
    @State private var selectedSizing: String? = nil
    @State private var navigateToHome = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
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

                SoleMateLogo.ProgressBar(current: 2, total: 2)
                    .padding(.horizontal)

                Image("sole-mate-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * 0.1)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Which sizing are you most familiar with?")
                        .font(.headline)
                    Text("This helps us show you shoes in the right size range and fit. Shoe construction varies by sizing system.")
                        .font(.subheadline)
                        .foregroundColor(.smBlack).multilineTextAlignment(.leading).lineLimit(nil).fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    SizingCard(
                        title: "Women's sizing",
                        subtitle: "Typically narrower fit\nWomen's 8 = Men's 6.5",
                        imageName: "womens-shoe-sizing",
                        isSelected: selectedSizing == "Women"
                    ) {
                        selectedSizing = "Women"
                    }

                    SizingCard(
                        title: "Men's sizing",
                        subtitle: "Typically wider fit\nMen's 9 = Women's 10.5",
                        imageName: "mens-shoe-sizing",
                        isSelected: selectedSizing == "Men"
                    ) {
                        selectedSizing = "Men"
                    }

                    SizingCard(
                        title: "Both/Either",
                        subtitle: "Show me options in both sizing systems",
                        imageName: "both-shoe-sizing",
                        isSelected: selectedSizing == "Both"
                    ) {
                        selectedSizing = "Both"
                    }
                }
                .padding(.horizontal)
                
                Text("This helps us show you shoes in the right size range and fit. Shoe construction varies by sizing system.")
                    .font(.subheadline)
                    .foregroundColor(.smBlack).padding(.horizontal).multilineTextAlignment(.leading).lineLimit(nil).fixedSize(horizontal: false, vertical: true)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()

                Button(action: {
                    saveFootMeasurements()
                }) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        Text(isLoading ? "Saving..." : "Save")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: 150)
                    .padding()
                    .background(Color.smRed)
                    .cornerRadius(AppConstants.CornerRadius.medium)
                }
                .disabled(isLoading || selectedSizing == nil)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .background(Color.background)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            Home()
        }
    }
    
    private func saveFootMeasurements() {
        guard let selectedSizing = selectedSizing,
              let lengthValue = Double(footLength),
              let widthValue = Double(footWidth) else {
            errorMessage = "Please complete all fields."
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated."
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        let lengthInches = lengthUnit == "in" ? lengthValue : lengthValue / 2.54
        let lengthCm = lengthUnit == "cm" ? lengthValue : lengthValue * 2.54
        let widthInches = widthUnit == "in" ? widthValue : widthValue / 2.54
        let widthCm = widthUnit == "cm" ? widthValue : widthValue * 2.54
        
        let footMeasurementData: [String: Any] = [
            "footLength": [
                "inches": lengthInches,
                "cm": lengthCm,
                "primaryUnit": lengthUnit
            ],
            "footWidth": [
                "inches": widthInches,
                "cm": widthCm,
                "primaryUnit": widthUnit
            ],
            "archType": archType,
            "preferredSizing": selectedSizing,
            "completedAt": Date().timeIntervalSince1970
        ]
        
        let ref = Database.database().reference()
        
        ref.child("users").child(uid).child("footMeasurements").setValue(footMeasurementData) { error, _ in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = "Failed to save measurements: \(error.localizedDescription)"
                    print("Database save error: \(error)")
                } else {
                    self.navigateToHome = true
                }
            }
        }
    }
}

#Preview {
    FootMeasurementsP2(
        footLength: "10.5",
        footWidth: "4.2",
        lengthUnit: "in",
        widthUnit: "in",
        archType: "Medium"
    )
}
