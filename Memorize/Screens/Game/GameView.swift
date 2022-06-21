//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Kotyak on 24.05.2022.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

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
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = GameViewModel()
//        GameView(viewModel: game)
//            .preferredColorScheme(.light)
//        GameView(viewModel: game)
//            .preferredColorScheme(.dark)
//    }
//}
