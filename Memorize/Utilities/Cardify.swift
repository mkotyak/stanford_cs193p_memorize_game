import SwiftUI

struct Cardify: ViewModifier {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
    var isFaceUp: Bool
    var cardColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: Constants.lineWidth)
                content
            } else {
                shape.fill(
                    LinearGradient(
                        colors: [cardColor, Color.white],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }
        }
        .foregroundColor(cardColor)
    }
}
