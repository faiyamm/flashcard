//
//  AddDeckView.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import SwiftUI

struct AddDeckView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedColorHex: String = "#00C099"
    
    let colors = ["#00C099", "#FFE38E", "#FFB6C1", "#ADD8E6", "#C1E1C1", "#D1D1F7"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Deck Details") {
                    TextField("Name for the deck...", text: $name)
                }
                
                Section("Choose Color") {
                    HStack {
                        ForEach(colors, id: \.self) { hex in
                            Circle()
                                .fill(Color(hex: hex))
                                .frame(width: 35, height: 35)
                                .overlay(
                                    Circle()
                                        .stroke(Color.primary, lineWidth: selectedColorHex == hex ? 2 : 0)
                                )
                                .onTapGesture {
                                    selectedColorHex = hex
                                }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("New Deck")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let t = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !t.isEmpty else { return }
                        
                        let newDeck = DeckModel(name: t, cards: [], colorHex: selectedColorHex)
                        store.decks.append(newDeck)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
