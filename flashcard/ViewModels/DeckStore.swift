//
//  DeckStore.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class DeckStore: ObservableObject {
    
    @Published var decks: [DeckModel] = [] {
        didSet { save() }
    }
    
    private let store = FileStore(filename: "decks.json")
    
    init() {
        load()
        if decks.isEmpty {
            decks = Self.dummyData
        }
    }
    
    // MARK: CRUD OPERATIONS
    func deleteCard(in deckID: UUID, at offSets: IndexSet) {
        guard let i = decks.firstIndex(where: { $0.id == deckID }) else {
            return
        }
        decks[i].cards.remove(atOffsets: offSets)
    }
    
    func addCard(to deckID: UUID, front: String, back: String) {
        guard let i = decks.firstIndex(where: { $0.id == deckID }) else {
            return
        }
        decks[i].cards.append(FlashcardModel(front: front, back: back))
    }
    
    func deck(for deckID: UUID) -> DeckModel? {
        decks.first(where: { $0.id == deckID })
    }
    
    func addDeck(name: String, colorHex: String) {
        let newDeck = DeckModel(name: name, cards: [], colorHex: colorHex)
        decks.append(newDeck)
    }
    
    func deleteDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets)
    }
    
    private func load() {
        do {
            decks = try store.load([DeckModel].self)
        } catch {
            decks = []
        }
    }
    
    private func save() {
        do {
            try store.save(decks)
        } catch {
            print("save error \(error)")
        }
    }
    
    static let dummyData: [DeckModel] = [
        DeckModel(name: "Personality vocabulary", cards: [
            FlashcardModel(front: "Ambitious", back: "Having a strong desire for success"),
            FlashcardModel(front: "Gregarious", back: "Fond of company; sociable")
        ], colorHex: "#00C099"),
        DeckModel(name: "IELTS Vocabulary 2", cards: [
            FlashcardModel(front: "Mitigate", back: "To make less severe"),
            FlashcardModel(front: "Pragmatic", back: "Dealing with things sensibly")
        ], colorHex: "#FFE38E")
    ]
}
