import Foundation
import SwiftUI

struct MemoryGameModel<CardContent> where CardContent: Equatable {
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
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id = UUID()
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var isSeen = false
        let content: CardContent
        var color: Color
        
        // MARK: - Bonus time
        
        // this could give matching bonus points
        // if the user matches the card
        // befire a certain amountt of time passes during which the card is face up
        
        // can be zero which means "no bomus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned gace up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has ben face up in the past
        // (i.e not including tthe current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus apportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percantege of the bonus time remainig
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether are currently face up, unmatched and have not yer used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
