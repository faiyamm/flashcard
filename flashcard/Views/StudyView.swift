//
//  StudyView.swift
//  flashcard
//
//  Created by Fai on 09/02/26.
//

import SwiftUI

struct StudyView: View {
    let deck: Deck
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 10
    @AppStorage("showBackFirst") private var showBackFirst: Bool = false
    
    @State private var index: Int = 0
    @State private var isFlipped: Bool = false
    @State private var sessionCards: [Flashcard] = []

    var body: some View {
        VStack(spacing: 25) {
            if sessionCards.isEmpty {
                Text("No cards in this deck.")
                    .foregroundStyle(.secondary)
            } else {
                Text("\(index + 1) / \(sessionCards.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(uiColor: .systemBackground))
                        .shadow(color: deck.color.opacity(0.4), radius: 15, x: 0, y: 8)
                    
                    VStack {
                        deck.color.frame(height: 10)
                        Spacer()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 24))

                    Text(currentText)
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(30)
                }
                .frame(height: 320)
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        isFlipped.toggle()
                    }
                }

                HStack(spacing: 20) {
                    Button(action: prev) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(.thinMaterial))
                    }
                    .disabled(index == 0)

                    Button(isFlipped ? "Show Front" : "Show Back") {
                        withAnimation { isFlipped.toggle() }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(deck.color)
                    .foregroundColor(.black)
                    .controlSize(.large)

                    Button(action: next) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(.thinMaterial))
                    }
                    .disabled(index == sessionCards.count - 1)
                }
            }
            Spacer()
        }
        .padding(.top)
        .navigationTitle(deck.name)
        .onAppear(perform: startSession)
    }

    private var currentText: String {
        guard !sessionCards.isEmpty else { return "" }
        let card = sessionCards[index]
        let showingFront = showBackFirst ? isFlipped : !isFlipped
        return showingFront ? card.front : card.back
    }

    private func startSession() {
        var cards = deck.cards
        if shuffleCards { cards.shuffle() }
        sessionCards = Array(cards.prefix(cardsPerSession))
        index = 0
        isFlipped = false
    }

    private func next() {
        if index < sessionCards.count - 1 {
            index += 1
            isFlipped = false
        }
    }

    private func prev() {
        if index > 0 {
            index -= 1
            isFlipped = false
        }
    }
}
