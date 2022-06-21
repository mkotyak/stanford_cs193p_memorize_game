//
//  Theme.swift
//  Memorize
//
//  Created by Maria Kotyak on 20.06.2022.
//

import Foundation

struct ThemeModel: Identifiable {
    var id = UUID()
    var name: String
    var numOfPairs: Int
    var emojis: [String]
    var color: String
}
