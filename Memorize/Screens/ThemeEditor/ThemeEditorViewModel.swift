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

    func remove(_ emoji: String) {
        if let index = theme.emojis.firstIndex(where: { $0.hashValue == emoji.hashValue }) {
            theme.emojis.remove(at: index)
        }
    }
}