//
//  AppConstants.swift
//  SoleMate
//
//  Created by Carlos Carrillo-Sandoval on 5/23/25.
//

import SwiftUI

struct AppConstants {
    struct Colors {
        static let SMRed = Color(.smRed)
        static let SMLightRed = Color(.smLightRed)
        static let backgroundColor = Color(.background)
        static let LightBackground = Color( .lightBackground)
        static let SMBlack = Color(.smBlack)
        static let cardBackgroundColor = Color(.cardBackground)
        static let backgroundOverlay = Color("ImageOverlay")
        static let cardShadow = Color.gray.opacity(0.2)
        static let secondaryText = Color.secondary
        static let borderGray = Color.gray.opacity(0.3)
    }
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xLarge: CGFloat = 40
    }
    
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xLarge: CGFloat = 20
    }
    
    struct FontSizes {
        static let caption: CGFloat = 12
        static let body: CGFloat = 16
        static let headline: CGFloat = 18
        static let title: CGFloat = 24
        static let largeTitle: CGFloat = 32
    }
}

struct ScreenConstants {
    static func dynamicSpacing(for geometry: GeometryProxy, factor: CGFloat = 0.03) -> CGFloat {
        return geometry.size.height * factor
    }
    
    static func dynamicFontSize(for geometry: GeometryProxy, base: CGFloat, maxSize: CGFloat) -> CGFloat {
        return min(geometry.size.width * (base / 100), maxSize)
    }
}
