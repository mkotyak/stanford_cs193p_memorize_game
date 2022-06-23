import Foundation

struct ThemeModel: Identifiable {
    var id = UUID()
    var name: String
    var numOfPairs: Int
    var emojis: [String]
    var color: String
}
