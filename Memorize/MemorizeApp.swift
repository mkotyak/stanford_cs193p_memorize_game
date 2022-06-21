//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maria Kotyak on 24.05.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = GameViewModel(theme: ThemeModel(name: "Test theme", numOfPairs: 6, emojis: ["🦁", "🦆", "🦐", "🐸", "🐞", "🦞"], color: "red"))
            GameView(viewModel: game)
//            ThemeView()
        }
    }
}
