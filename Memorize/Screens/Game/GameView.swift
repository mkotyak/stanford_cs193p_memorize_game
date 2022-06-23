import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
        .navigationTitle(viewModel.title)
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
