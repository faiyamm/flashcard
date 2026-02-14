//
//  DeckModel.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct DeckModel: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var cards: [FlashcardModel]
    var colorHex: String

    init(id: UUID = UUID(), name: String, cards: [FlashcardModel], colorHex: String = "#00C099") {
        self.id = id
        self.name = name
        self.cards = cards
        self.colorHex = colorHex
    }
    
    var color: Color {
        Color(hex: colorHex)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: (r, g, b) = (0, 192, 153)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
