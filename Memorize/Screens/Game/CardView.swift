import SwiftUI

struct CardView: View {
    private enum Constants {
        static let fontScale: CGFloat = 0.7
        static let pieShapePadding: CGFloat = 5
        static let pieShapeOpacity: CGFloat = 0.5
    }

    let card: GameViewModel.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                PieShape(
                    startAngle: Angle(degrees: 0-90),
                    endAngle: Angle(degrees: 110-90)
                )
                .padding(Constants.pieShapePadding)
                .opacity(Constants.pieShapeOpacity)
                Text(card.content)
                    .font(font(in: geometry.size))
            }
        }
        .modifier(Cardify(isFaceUp: card.isFaceUp, cardColor: card.color))
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constants.fontScale)
    }
}
