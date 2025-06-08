//
//  Shoe.swift
//  SoleMate
//
//  Created by Jung H Hwang on 6/8/25.
//


import SwiftUI

struct Shoe: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: String
    let description: String
    let imageName: String
}
