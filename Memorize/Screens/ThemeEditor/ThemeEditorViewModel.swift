import Foundation
import SwiftUI

class ThemeEditorViewModel: ObservableObject {
    @Binding var theme: ThemeModel

    var name: String {
        get { theme.name }
        set { theme.name = newValue }
    }

    var emojis: [String] {
        theme.emojis
    }

    var removedEmojis: [String] {
        theme.removedEmojis
    }

    var color: Color {
        switch theme.color {
        case "red":
            return .red
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "mint":
            return .mint
        case "blue":
            return .blue
        case "purple":
            return .purple
        default:
            return .black
        }
    }

    init(theme: Binding<ThemeModel>) {
        self._theme = theme
    }

    func add(_ emoji: Character?) {
        guard let emoji = emoji else {
            return
        }

        guard emoji.isEmoji,
              !theme.emojis.contains(String(emoji))
        else {
            return
        }

        theme.emojis.insert(String(emoji), at: 0)
    }

    func returnBack(_ emoji: String) {
        if let index = theme.removedEmojis.firstIndex(where: { $0.hashValue == emoji.hashValue }) {
            let emojiToReturn = theme.removedEmojis.remove(at: index)
            theme.emojis.insert(emojiToReturn, at: 0)
        }
    }

    func remove(_ emoji: String) {
        if let index = theme.emojis.firstIndex(where: { $0.hashValue == emoji.hashValue }) {
            let removedEmogi = theme.emojis.remove(at: index)
            theme.removedEmojis.append(removedEmogi)
        }
    }

    func pairsCount() -> Int {
        var count = 0

        switch theme.numOfPairs {
        case .explicit(let num):
            count = num
        case .all, .random:
            break
        }
        return count
    }

    func updatePairs(_ value: String) {
        switch value {
        case "All":
            theme.numOfPairs = .all
        case "Random":
            theme.numOfPairs = .random
        case "Explicit":
            theme.numOfPairs = .explicit(0)
        default:
            break
        }
    }

    func incrementPairsCount(_ newValue: Int) {
        theme.numOfPairs = .explicit(min(emojis.count, newValue))
    }

    func decrementPairsCount(_ newValue: Int) {
        theme.numOfPairs = .explicit(newValue)
    }

    func applyColor(_ color: Color) {
        switch color {
        case .red:
            theme.color = "red"
        case .orange:
            theme.color = "orange"
        case .yellow:
            theme.color = "yellow"
        case .green:
            theme.color = "green"
        case .mint:
            theme.color = "mint"
        case .blue:
            theme.color = "blue"
        case .purple:
            theme.color = "purple"
        default:
            theme.color = "black"
        }
    }
}
