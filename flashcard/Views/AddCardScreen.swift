//
//  AddCardScreen.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct AddCardScreen: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    
    let deckID: UUID
    
    @State private var front = ""
    @State private var back = ""
    
    private var deckColor: Color {
        store.deck(for: deckID)?.color ?? .blue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Front") {
                    TextField("Question / term", text: $front)
                }
                
                Section("Back") {
                    TextField("Answer / definition", text: $back)
                }
            }
            .navigationTitle("Add Card")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let f = front.trimmingCharacters(in: .whitespacesAndNewlines)
                        let b = back.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        guard !f.isEmpty, !b.isEmpty else { return }
                        
                        store.addCard(to: deckID, front: f, back: b)
                        dismiss()
                    }
                    .tint(deckColor)
                    .disabled(front.isEmpty || back.isEmpty)
                }
            }
        }
    }
}
