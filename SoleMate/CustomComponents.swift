//
//  CustomComponents.swift
//  SoleMate
//
//  Created by Carlos Carrillo-Sandoval on 5/23/25.
//

import SwiftUI

struct SoleMateLogo : View {
    var body: some View {
        Image(systemName: "sole-mate-logo").font(.system(size: 40, weight: .light))
            .foregroundColor(Color.smRed)
    }
    
    struct ProgressBar: View {
        let current: Int
        let total: Int
        
        var body: some View{
            GeometryReader { geometry in VStack(alignment: .leading, spacing: AppConstants.Spacing.small){
                Text("Step \(current) of \(total)").font(.subheadline).foregroundColor(AppConstants.Colors.SMBlack)
                ZStack(alignment: .leading){
                    Rectangle().fill(Color.smLightRed).frame(height: 4).cornerRadius(2)
                    Rectangle().fill(Color.smRed).frame(width: geometry.size.width * ((CGFloat(current) / CGFloat(total))), height: 4).cornerRadius(2)
                }
            }
            }
            .frame(height: 30)
        }
    }
    
    struct PrimaryButton: View{
        let title: String
        let action: () -> Void
        
        var body: some View{
            Button(action:action){
                Text(title).font(.headline).foregroundColor(.white).frame(maxWidth: 150).padding().background(Color.smRed).cornerRadius(AppConstants.CornerRadius.medium)
            }
        }
    }
    
    struct SecondaryButton: View{
        let title: String
        let action: () -> Void
        
        var body: some View{
            Button(action:action){
                Text(title).font(.headline).foregroundColor(.primary).frame(maxWidth: .infinity).padding().background(Color.smLightRed).cornerRadius(AppConstants.CornerRadius.medium)
            }
        }
    }
    
    struct UnitToggle: View {
        @Binding var selectedUnit: String
        let options: [String]
        
        var body: some View {
            HStack(spacing: 0) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedUnit = option
                    }) {
                        Text(option)
                            .font(.subheadline)
                            .padding(.horizontal, AppConstants.Spacing.medium)
                            .padding(.vertical, AppConstants.Spacing.small)
                            .background(selectedUnit == option ? Color.smRed : Color.smLightRed)
                            .foregroundColor(selectedUnit == option ? .white : .primary)
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(AppConstants.CornerRadius.xLarge)
        }
    }
    
    struct ArchTypeButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.subheadline)
                    .padding(.horizontal, AppConstants.Spacing.large)
                    .padding(.vertical, AppConstants.Spacing.medium)
                    .background(isSelected ? Color.smRed : Color.smLightRed)
                    .foregroundColor(isSelected ? .white : .primary)
                    .cornerRadius(AppConstants.CornerRadius.xLarge)
            }
        }
    }
    
}

struct SizingCard: View {
    let title: String
    let subtitle: String
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).bold()
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary).multilineTextAlignment(.leading).lineLimit(nil).fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding()
            .background(isSelected ? Color.smRed : Color.white)
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}

