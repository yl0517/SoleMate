// Shoe.swift
import Foundation

struct Shoe: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let activities: [String]
    let sizingOption: String
    let sizeRange: SizeRange
    let archType: String
    let price: Double

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

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
