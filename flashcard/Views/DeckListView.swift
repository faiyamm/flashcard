//
//  DeckListView.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct DeckListView: View {
    @EnvironmentObject var store: DeckStore
    @State private var showingAddDeck = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(store.decks) { deck in
                    NavigationLink(destination: DeckDetailview(deckID: deck.id)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(deck.name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Text("\(deck.cards.count) cards")
                                .font(.system(size: 14))
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, minHeight: 140, alignment: .leading)
                        .background(deck.color)
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Flashcards")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { showingAddDeck = true } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $showingAddDeck) {
            AddDeckView()
        }
    }
}
