//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maria Kotyak on 16.06.2022.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var model: MemoryGameModel<String> = createMemoryGame(
        theme: ThemeModel(
            name: "Food",
            numOfPairs: 6,
            emojis: ["🍔", "🌭", "🌮", "🥙", "🥓", "🍕", "🍎", "🍇"],
            color: "green"
        )
    )
    
//    init(theme: ThemeModel) {
//        
//    }

    static func createMemoryGame(theme: ThemeModel) -> MemoryGameModel<String> {
        let emojis = ["🍔", "🌭", "🌮", "🥙", "🥓", "🍕", "🍎", "🍇"]
        return MemoryGameModel(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }

    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }


    // MARK: - Intent(s)

    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}
