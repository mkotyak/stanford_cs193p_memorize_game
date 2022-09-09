import Foundation
import SwiftUI

class ColorAdapter {
    func convertColor(color: String) -> Color {
        switch color {
        case "red":
            return .red
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "mint":
            return .mint
        case "blue":
            return .blue
        case "purple":
            return .purple
        default:
            return .black
        }
    }
}
