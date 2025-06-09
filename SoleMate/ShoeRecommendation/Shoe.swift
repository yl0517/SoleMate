// Shoe.swift
import Foundation

struct Shoe: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let activities: [String]
    let sizingOption: String
    let sizeRange: SizeRange
    let archType: String

    // Stub out the UI‐properties your views expect:
    var price: String       { "" }
    var description: String { "" }
    var imageName: String?  { nil }

    // Equatable conformance so you can call `favorites.contains(shoe)`:
    static func ==(lhs: Shoe, rhs: Shoe) -> Bool {
        lhs.id == rhs.id
    }
}

struct SizeRange: Decodable {
    let minFootLength: Double
    let maxFootLength: Double
    let footLengthUnit: String
    let minFootWidth: Double
    let maxFootWidth: Double
    let footWidthUnit: String
}
