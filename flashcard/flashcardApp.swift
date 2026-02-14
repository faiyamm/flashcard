//
//  flashcardApp.swift
//  flashcard
//
//  Created by Fai on 09/02/26.
//

import SwiftUI

@main
struct flashcardApp: App {
    @StateObject private var store = DeckStore()
    @AppStorage("darkMode") private var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DeckListView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .environmentObject(store)
        }
    }
}
