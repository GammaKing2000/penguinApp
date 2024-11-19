//
//  ChatMessage.swift
//  Penguin
//
//  Created by Karman Fung on 18/11/2024.
//
import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let isUser: Bool
    let text: String
}
