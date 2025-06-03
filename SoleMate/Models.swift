//
//  Models.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/3/25.
//

import Foundation

// Sizing system
enum SizingOption: String, CaseIterable {
    case women = "Women’s sizing"
    case men   = "Men’s sizing"
    case both  = "Both/Either"
}

// Units for length
enum LengthUnit: String, CaseIterable {
    case inches = "in"
    case cm     = "cm"
}

// Units for width
enum WidthUnit: String, CaseIterable {
    case inches = "in"
    case cm     = "cm"
}

// Arch types
enum ArchType: String, CaseIterable {
    case flat   = "Flat"
    case medium = "Medium"
    case high   = "High"
}
