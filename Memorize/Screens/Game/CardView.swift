import SwiftUI

struct CardView: View {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let pieShapePadding: CGFloat = 5
        static let pieShapeOpacity: CGFloat = 0.5
    }

    let card: GameViewModel.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: Constants.lineWidth)
                    PieShape(
                        startAngle: Angle(degrees: 0-90),
                        endAngle: Angle(degrees: 110-90)
                    )
                    .padding(Constants.pieShapePadding)
                    .opacity(Constants.pieShapeOpacity)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else {
                    shape.fill(
                        LinearGradient(
                            colors: [card.color, Color.white],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                }
            }
        }
        .foregroundColor(card.color)
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constants.fontScale)
    }
}
