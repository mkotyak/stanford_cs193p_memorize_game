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
    var score: Int {
        model.score
    }
    
    init(theme: ThemeModel, allAvailableThemes: [ThemeModel]) {
        model = GameViewModel.createMemoryGame(theme: theme)
        themes = allAvailableThemes
        gameName = theme.name
    }

    static func createMemoryGame(theme: ThemeModel) -> MemoryGameModel<String> {
        let shuffledEmojis = Set(theme.emojis).shuffled()
        // Extra credit #2 - added randomNumOfPairs const to use as a numOfPairs for themes without specific num of pairs
        let randomNumOfPairs = Int.random(in: 4..<shuffledEmojis.count)
        var validatedNumOfPairs = 0
        // Extra credit #1 and #2
        if theme.numOfPairs != nil {
            validatedNumOfPairs = min(theme.numOfPairs!, shuffledEmojis.count)
        } else {
            // Extra credit #1 - use all the emoji available in the theme if the code that creates the Theme doesn’t want to explicitly specify how many pairs to use
//            validatedNumOfPairs = theme.emojis.count
            // Extra credit #2 - Allow the creation of some Themes where the number of pairs of cards to show is not a specific number but is, instead, a random number
            validatedNumOfPairs = randomNumOfPairs
        }
        
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
