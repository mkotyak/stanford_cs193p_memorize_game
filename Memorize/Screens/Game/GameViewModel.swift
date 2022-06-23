import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var model: MemoryGameModel<String>
    let themes: [ThemeModel]
    var gameName: String
    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }
    var title: String {
        gameName
    }
    
    init(theme: ThemeModel, allAvailableThemes: [ThemeModel]) {
        model = GameViewModel.createMemoryGame(theme: theme)
        themes = allAvailableThemes
        gameName = theme.name
    }

    static func createMemoryGame(theme: ThemeModel) -> MemoryGameModel<String> {
        let shuffledEmojis = Set(theme.emojis).shuffled()
        let validatedNumOfPairs = min(theme.numOfPairs, shuffledEmojis.count)
        
        return MemoryGameModel(numberOfPairsOfCards: validatedNumOfPairs) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }

    // MARK: - Intent(s)

    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
    
    func createNewRandomGame() {
        guard let newTheme = themes.randomElement() else {
            return
        }
        model = GameViewModel.createMemoryGame(theme: newTheme)
        gameName = newTheme.name
    }
}
