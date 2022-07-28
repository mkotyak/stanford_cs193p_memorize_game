import Foundation
import SwiftUI

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    struct Card: Identifiable {
        let id = UUID()
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        var color: Color
    }

    private(set) var cards: [Card]
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    var score = 0
    let defaultScoreBonus = 2
    let defaultScorePenalty = 1
    let startGameDate: Date
    var previousMatchDate: Date?
    let scoreBonuInterval: TimeInterval = 10

    init(numberOfPairsOfCards: Int, color: Color, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        startGameDate = .now
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, color: color))
            cards.append(Card(content: content, color: color))
        }
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }
        guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            return
        }
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                let matchDate = Date.now
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                let matchTimeInterval = matchDate.timeIntervalSince(previousMatchDate ?? startGameDate)
                score += defaultScoreBonus + extraBonus(for: matchTimeInterval)
                previousMatchDate = matchDate
                debugPrint(matchTimeInterval)
            } else if cards[chosenIndex].isSeen {
                score -= defaultScorePenalty
            }
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].isFaceUp = false
                    cards[index].isSeen = true
                }
            }
            if cards[chosenIndex].isSeen {
                score -= defaultScorePenalty
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp = true
    }

    mutating func extraBonus(for matchTimeInterval: TimeInterval) -> Int {
        guard matchTimeInterval < scoreBonuInterval, matchTimeInterval > 0 else {
            return 0
        }
        return Int(scoreBonuInterval - matchTimeInterval)
    }
}
