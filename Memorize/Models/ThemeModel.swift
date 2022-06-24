import Foundation

struct ThemeModel: Identifiable {
    var id = UUID()
    var name: String
    // Extra credit #1 - replace Int with Int?
    var numOfPairs: Int?
    var emojis: [String]
    var color: String
    
    // Extra credit #1
    init(name: String, emojis: [String], color: String) {
        self.name = name
        self.emojis = emojis
        self.color = color
    }
    
    // Extra credit #1
    init(name: String, numOfPairs: Int, emojis: [String], color: String) {
        self.name = name
        self.numOfPairs = numOfPairs
        self.emojis = emojis
        self.color = color
    }
}
