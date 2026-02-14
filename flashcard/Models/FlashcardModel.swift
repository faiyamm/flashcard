//
//  FlashcardModel.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct Deck: Identifiable {
    let id = UUID()
    var name: String
    var cards: [Flashcard]
    var color: Color
}

struct Flashcard: Identifiable {
    let id = UUID()
    var front: String
    var back: String
}
