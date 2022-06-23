import Foundation
import UIKit

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    struct Card: Identifiable {
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen = false
        var content: CardContent
    }
    
    private(set) var cards: [Card]
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    var score = 0
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
//      add numberOfPairOfCards x 2 cards to cards array
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            debugPrint("Card is out of scope")
            return
        }
        guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            debugPrint("Card is faceUp or isMatched")
            return
        }
        
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            debugPrint("only one card is fase up")
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2
            } else if cards[chosenIndex].isSeen {
                score -= 1
            }
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            debugPrint("NOT only one card is fase up")
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].isFaceUp = false
                    cards[index].isSeen = true
                }
            }
            if cards[chosenIndex].isSeen {
                score -= 1
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp.toggle()
    }
}
