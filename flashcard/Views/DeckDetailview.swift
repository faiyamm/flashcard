//
//  DeckDetailview.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct DeckDetailview: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingAddCard = false
    let deckID: UUID
    
    private var deck: DeckModel? {
        store.deck(for: deckID)
    }
    
    var body: some View {
        List {
            if let deck = deck {
                Section {
                    NavigationLink {
                        StudyView(deck: deck)
                    } label: {
                        HStack {
                            Label("Study this deck", systemImage: "play.circle.fill")
                                .font(.headline)
                                .foregroundColor(deck.color)
                            Spacer()
                            Text("\(deck.cards.count) cards")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section("Cards") {
                    if deck.cards.isEmpty {
                        Text("No cards yet – add one!")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        ForEach(deck.cards) { card in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(card.front)
                                    .font(.headline)
                                Text(card.back)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { offsets in
                            store.deleteCard(in: deckID, at: offsets)
                        }
                    }
                }
            } else {
                Text("Deck not found")
            }
        }
        .navigationTitle(deck?.name ?? "Deck")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddCard = true
                } label: {
                    Image(systemName: "plus")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(deck?.color ?? .blue, .secondary.opacity(0.3))
                        .font(.title3)
                }
                .disabled(deck == nil)
            }
        }
        .sheet(isPresented: $showingAddCard) {
            AddCardScreen(deckID: deckID)
        }
    }
}
