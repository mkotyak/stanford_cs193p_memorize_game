import SwiftUI

struct GameView: View {
    private enum Constants {
        static let cardsPadding: CGFloat = 4
        static let cardsAspectRatio: CGFloat = 2 / 3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealtWidth = undealHeight * cardsAspectRatio
    }

    @StateObject var viewModel: GameViewModel
//    @State private var dealt = Set<UUID>()
//    @Namespace private var dealingNamespace

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    shuffleButton
                    Spacer()
                    newGameButton
                }
                .padding()
            }
//            deckBody
        }
        .padding(.horizontal)
        .navigationTitle("\(viewModel.title) (score: \(viewModel.score))")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var newGameButton: some View {
        Button(action: {
            withAnimation {
//                dealt = []
                viewModel.createNewRandomGame()
            }
        }, label: {
            Text("New game")
        })
    }

    private var gameBody: some View {
        AspectVGrid(
            items: viewModel.cards,
            aspectRatio: Constants.cardsAspectRatio
        ) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
//                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(Constants.cardsPadding)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale))
//                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
    }

    private var shuffleButton: some View {
        Button {
            withAnimation {
                viewModel.shuffle()
            }
        } label: {
            Text("Shuffle")
        }
    }
}

//    private var deckBody: some View {
//        ZStack {
//            ForEach(viewModel.cards.filter(isUndelt)) { card in
//                CardView(card: card)
//                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
//                    .zIndex(zIndex(of: card))
//            }
//        }
//        .frame(width: Constants.undealtWidth, height: Constants.undealHeight)
//        .foregroundColor(.red)
//        .onTapGesture {
//            for card in viewModel.cards {
//                withAnimation(dealAnimation(for: card)) {
//                    deal(card)
//                }
//            }
//        }
//    }

//    private func dealAnimation(for card: GameViewModel.Card) -> Animation {
//        var delay = 0.0
//
//        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
//            delay = Double(index) * (Constants.totalDealDuration / Double(viewModel.cards.count))
//        }
//        return Animation.easeInOut(duration: Constants.dealDuration).delay(delay)
//    }

//    private func zIndex(of card: GameViewModel.Card) -> Double {
//        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
//    }
//
//    private func deal(_ card: GameViewModel.Card) {
//        dealt.insert(card.id)
//    }
//
//    private func isUndelt(_ card: GameViewModel.Card) -> Bool {
//        return !dealt.contains(card.id)
//    }
// }
