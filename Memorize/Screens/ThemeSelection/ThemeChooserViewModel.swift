import Foundation
import SwiftUI

class ThemeChooserViewModel: ObservableObject {
    @Published var themes = [ThemeModel]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeChooserKey"
    }
    
    init() {
        restoreFromUserDefaults()
        
        if themes.isEmpty {
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
                numOfPairs: .explicit(6),
                emojis: ["🐶", "🐱", "🐻‍❄️", "🦁", "🐷", "🦊", "🐻", "🐵"],
                color: "red")
            )
        }
    }
    
    func subtitle(for theme: ThemeModel) -> String {
        Set(theme.emojis).sorted().joined()
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
        debugPrint("changes have been saved to the userDefaults")
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode([ThemeModel].self, from: jsonData)
        {
            themes = decodedThemes
        }
    }
}
