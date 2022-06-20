//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maria Kotyak on 16.06.2022.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = [
        "😄", "☎️", "👑", "🦊", "🌲",
        "🌖", "⛄️", "🍎", "🍟", "🍿",
        "⚽️", "💣", "🧸", "❤️", "🎵",
        "🏳️‍🌈", "🦖", "🔴", "📞", "⛩"
    ]
    
    @Published private var model: MemoryGame<String> = createMemoryGame()

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}


