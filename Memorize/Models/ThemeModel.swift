import Foundation

struct ThemeModel: Identifiable, Codable {
    
    enum NumOfPairs: Codable, Hashable {
        case all
        case random
        case explicit(Int)
    }
    
    var id = UUID()
    var name: String
    var numOfPairs: NumOfPairs
    var emojis: [String]
    var color: String
    var removedEmojis: [String] = []
}
