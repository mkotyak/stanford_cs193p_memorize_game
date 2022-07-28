import SwiftUI

struct GameView: View {
    private enum Constants {
        static let faceDownRectangleOpacity: CGFloat = 0
        static let cardsPadding: CGFloat = 4
        static let cardsAspectRatio: CGFloat = 2 / 3
    }

    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        AspectVGrid(
            items: viewModel.cards,
            aspectRatio: Constants.cardsAspectRatio
        ) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(Constants.faceDownRectangleOpacity)
            } else {
                CardView(card: card)
                    .padding(Constants.cardsPadding)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .padding(.horizontal)
        .navigationTitle("\(viewModel.title) (score: \(viewModel.score))")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            trailing: Button(action: {
                viewModel.createNewRandomGame()
            }, label: {
                Text("New game")
            })
        )
    }
}
