//
//  ThemeSelectionViewModel.swift
//  Memorize
//
//  Created by Maria Kotyak on 20.06.2022.
//

import Foundation
import SwiftUI

class ThemeSelectionViewModel: ObservableObject {
    var themes: [ThemeModel] = []

    init() {
        themes.append(ThemeModel(
            name: "Halloween",
            numOfPairs: 6,
            emojis: ["💀", "👻", "🎃", "🕸", "🕷", "🦇"],
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
    }
    
    static func convertColor(color: String) -> Color {
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
