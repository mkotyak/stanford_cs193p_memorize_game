import Foundation
import SwiftUI

class ThemeSelectionViewModel: ObservableObject {
    @Published var themes: [ThemeModel] = []
 
    init() {
        themes.append(ThemeModel(
            name: "Halloween",
            numOfPairs: .explicit(6),
            emojis: ["💀", "👻", "🎃", "🕸", "🕷", "🦇", "💀"],
            color: "orange")
        )
        
        themes.append(ThemeModel(
            name: "Food",
            numOfPairs: .all,
            emojis: ["🍔", "🌭", "🌮", "🥙", "🥓", "🍕", "🍎", "🍇"],
            color: "green")
        )
        
        themes.append(ThemeModel(
            name: "Vehicle",
            numOfPairs: .explicit(6),
            emojis: ["🚗", "🚌", "🏎", "🚑", "🛴", "🚲", "✈️", "🚀"],
            color: "blue")
        )
        
        themes.append(ThemeModel(
            name: "Flags",
            numOfPairs: .all,
            emojis: ["🇺🇦", "🏳️‍🌈", "🇪🇺", "🇺🇸", "🇰🇷", "🇵🇱", "🇷🇴", "🇵🇪"],
            color: "mint")
        )
        
        themes.append(ThemeModel(
            name: "Faces",
            numOfPairs: .explicit(6),
            emojis: ["😃", "😆", "🥹", "😍", "🤩", "😢", "🥳", "😡"],
            color: "yellow")
        )
        
        themes.append(ThemeModel(
            name: "Animals",
            numOfPairs: .random,
            emojis: ["🐶", "🐱", "🐻‍❄️", "🦁", "🐷", "🦊", "🐻", "🐵"],
            color: "pink")
        )
    }
}
