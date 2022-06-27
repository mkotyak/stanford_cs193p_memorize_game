import Foundation

struct ThemeModel: Identifiable {
    enum NumOfPairs {
        case all
        case random
        case explicit(Int)
    }
    
    var id = UUID()
    var name: String
    var numOfPairs: NumOfPairs
    var emojis: [String]
    var color: String
}
