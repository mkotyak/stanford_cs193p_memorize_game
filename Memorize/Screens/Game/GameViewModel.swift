import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    typealias Card = MemoryGameModel<String>.Card
    
    @Published private var model: MemoryGameModel<String>
    let themes: [ThemeModel]
    var gameName: String
    var cards: [Card] {
        model.cards
    }

    var title: String {
        gameName
    }

    var score: Int {
        model.score
    }

    init(theme: ThemeModel, allAvailableThemes: [ThemeModel]) {
        model = GameViewModel.createMemoryGame(theme: theme)
        themes = allAvailableThemes
        gameName = theme.name
    }

     private static func createMemoryGame(theme: ThemeModel) -> MemoryGameModel<String> {
        let shuffledEmojis = Set(theme.emojis).shuffled()
        let validatedNumOfPairs: Int

        switch theme.numOfPairs {
        case .all:
            validatedNumOfPairs = shuffledEmojis.count
        case .explicit(let numOfPairs):
            validatedNumOfPairs = min(numOfPairs, shuffledEmojis.count)
        case .random:
            validatedNumOfPairs = Int.random(in: 4 ..< shuffledEmojis.count)
        }

        return MemoryGameModel(
            numberOfPairsOfCards: validatedNumOfPairs,
            color: ColorAdapter().convertColor(color: theme.color)
        ) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }

    // MARK: - Intent(s)

    func choose(_ card: Card) {
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
