import SwiftUI

struct CardView: View {
    private enum Constants {
        static let fontScale: CGFloat = 0.7
        static let pieShapePadding: CGFloat = 5
        static let pieShapeOpacity: CGFloat = 0.5
    }

    let card: GameViewModel.Card
    @State private var animatedBonusRemaining: Double = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        PieShape(
                            startAngle: Angle(degrees: 0-90),
                            endAngle: Angle(degrees: (1-animatedBonusRemaining) * 360-90)
                        )
                        .onAppear() {
                            animatedBonusRemaining = card.bonusRemaining
                            withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                animatedBonusRemaining = 0
                            }
                        }
                    } else {
                        PieShape(
                            startAngle: Angle(degrees: 0-90),
                            endAngle: Angle(degrees: (1-card.bonusRemaining) * 360-90)
                        )
                    }
                }
                .padding(Constants.pieShapePadding)
                .opacity(Constants.pieShapeOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 1).repeatForever(autoreverses: false),
                        value: card.isMatched
                    )
                    .font(font(in: geometry.size))
            }
        }
        .cardify(isFaceUp: card.isFaceUp, cardColor: card.color)
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constants.fontScale)
    }
}
