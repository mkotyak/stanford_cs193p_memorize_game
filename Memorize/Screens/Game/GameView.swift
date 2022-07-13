import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2 / 3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
            CardView(card: card)
                .padding(4)
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
