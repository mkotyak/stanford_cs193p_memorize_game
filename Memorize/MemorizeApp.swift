//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maria Kotyak on 24.05.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModal: game)
        }
    }
}
