// Models.swift
// SoleMate
//
// Created by Yoobin Lee on 6/3/25.
//

import Foundation

// Sizing system
enum SizingOption: String, CaseIterable, Codable {
    case women = "Women"
    case men   = "Men"
    case both  = "Both"
}

// Units for length
enum LengthUnit: String, CaseIterable, Codable {
    case inches = "in"
    case cm     = "cm"
}

// Units for width
enum WidthUnit: String, CaseIterable, Codable {
    case inches = "in"
    case cm     = "cm"
}

// Arch types
enum ArchType: String, CaseIterable, Codable {
    case flat   = "Flat"
    case medium = "Medium"
    case high   = "High"
}

struct ShoeConfiguration: Codable {
    let selectedActivities: [String]
    let otherActivity: String?
    let sizingOption: SizingOption
    let footLength: Double
    let footLengthUnit: LengthUnit
    let footWidth: Double
    let footWidthUnit: WidthUnit
    let archType: ArchType
    let savedAt: Date
}

extension UserDefaults {
    private static let configKey = "ShoeConfigurationKey"

    var shoeConfiguration: ShoeConfiguration? {
        get {
            guard let data = data(forKey: Self.configKey) else { return nil }
            return try? JSONDecoder().decode(ShoeConfiguration.self, from: data)
        }
        set {
            if let newValue = newValue,
               let data = try? JSONEncoder().encode(newValue) {
                set(data, forKey: Self.configKey)
            } else {
                removeObject(forKey: Self.configKey)
            }
        }
    }
}
