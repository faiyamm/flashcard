//
//  FlashcardModel.swift
//  flashcard
//
//  Created by Fai on 13/02/26.
//

import Foundation

struct FlashcardModel: Identifiable, Codable, Equatable {
    let id: UUID
    let front: String
    var back: String
    
    init(id: UUID = UUID(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
}
