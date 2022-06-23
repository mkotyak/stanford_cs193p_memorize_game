import Foundation
import SwiftUI

class ThemeSelectionViewModel: ObservableObject {
    @Published var themes: [ThemeModel] = []

    init() {
        themes.append(ThemeModel(
            name: "Halloween",
            numOfPairs: 6,
            emojis: ["💀", "👻", "🎃", "🕸", "🕷", "🦇", "💀"],
            color: "orange")
        )
        
        themes.append(ThemeModel(
            name: "Food",
            numOfPairs: 6,
            emojis: ["🍔", "🌭", "🌮", "🥙", "🥓", "🍕", "🍎", "🍇"],
            color: "green")
        )

        themes.append(ThemeModel(
            name: "Vehicle",
            numOfPairs: 6,
            emojis: ["🚗", "🚌", "🏎", "🚑", "🛴", "🚲", "✈️", "🚀"],
            color: "blue")
        )
        
        themes.append(ThemeModel(
            name: "Flags",
            numOfPairs: 6,
            emojis: ["🇺🇦", "🏳️‍🌈", "🇪🇺", "🇺🇸", "🇰🇷", "🇵🇱", "🇷🇴", "🇵🇪"],
            color: "mint")
        )
        
        themes.append(ThemeModel(
            name: "Faces",
            numOfPairs: 6,
            emojis: ["😃", "😆", "🥹", "😍", "🤩", "😢", "🥳", "😡"],
            color: "yellow")
        )
        
        themes.append(ThemeModel(
            name: "Animals",
            numOfPairs: 6,
            emojis: ["🐶", "🐱", "🐻‍❄️", "🦁", "🐷", "🦊", "🐻", "🐵"],
            color: "purple")
        )
    }
    
//    init(newTheme: ThemeModel) {
//        themes.append(newTheme)
//    }
    
    func convertColor(color: String) -> Color {
        switch color {
        case "orange":
            return .orange
        case "green":
            return .green
        case "blue":
            return .blue
        case "mint":
            return .mint
        case "white":
            return .white
        case "yellow":
            return .yellow
        case "purple":
            return .purple
        case "pink":
            return .pink
        default:
            return .black
        }
    }
}
