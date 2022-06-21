//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maria Kotyak on 16.06.2022.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var model: MemoryGameModel<String>

    init(theme: ThemeModel) {
        model = GameViewModel.createMemoryGame(theme: theme)
    }

    static func createMemoryGame(theme: ThemeModel) -> MemoryGameModel<String> {
        let shuffledEmojis = Set(theme.emojis).shuffled()
        let validatedNumOfPairs = min(theme.numOfPairs, shuffledEmojis.count)
        
        return MemoryGameModel(numberOfPairsOfCards: validatedNumOfPairs) { pairIndex in
            shuffledEmojis[pairIndex]
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
