//
//  Mood.swift
//  Penguin
//
//  Created by Karman Fung on 18/11/2024.
//

import Foundation

struct Mood: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    var isSelected: Bool = false
}
