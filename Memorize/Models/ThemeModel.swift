import Foundation

struct ThemeModel: Identifiable, Codable {
    enum NumOfPairs: Codable {
        case all
        case random
        case explicit(Int)
        case none 
    }
    
    var id = UUID()
    var name: String
    var numOfPairs: NumOfPairs
    var emojis: [String]
    var color: String
}
