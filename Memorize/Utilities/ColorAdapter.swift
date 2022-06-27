import Foundation
import SwiftUI

class ColorAdapter {
    func convertColor(color: String) -> Color {
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
