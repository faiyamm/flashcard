//
//  DeckListView.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct DeckListView: View {
    @EnvironmentObject var store: DeckStore
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(store.decks) { deck in
                    NavigationLink(destination: StudyView(deck: deck)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(deck.name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            
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
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}
