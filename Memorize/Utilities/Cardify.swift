import SwiftUI

struct Cardify: AnimatableModifier {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
    init(isFaceUp: Bool, cardColor: Color) {
        rotation = isFaceUp ? 0 : 180
        self.cardColor = cardColor
    }
    
    var animatableData: Double {
        get { rotation }
        set {rotation = newValue}
    }
    
    var cardColor: Color
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: Constants.lineWidth)
            } else {
                shape.fill(
                    LinearGradient(
                        colors: [cardColor, Color.white],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
        .foregroundColor(cardColor)
    }
}

extension View {
    func cardify(isFaceUp: Bool, cardColor: Color) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, cardColor: cardColor))
    }
}
