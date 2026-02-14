//
//  DeckStore.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI
import Combine

final class DeckStore: ObservableObject {
    @Published var decks: [Deck] = [
        Deck(name: "Personality vocabulary",
             cards: [
                Flashcard(front: "Ambitious", back: "Having a strong desire for success"),
                Flashcard(front: "Gregarious", back: "Fond of company; sociable")
             ],
             color: Color(red: 0, green: 0.75, blue: 0.6)),
        Deck(name: "IELTS Vocabulary 2",
             cards: [
                Flashcard(front: "Mitigate", back: "To make less severe"),
                Flashcard(front: "Pragmatic", back: "Dealing with things sensibly")
             ],
             color: Color(red: 1, green: 0.84, blue: 0.4))
    ]
}
