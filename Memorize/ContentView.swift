//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Kotyak on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModal: EmojiMemoryGame

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                ForEach(viewModal.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .onTapGesture {
                            viewModal.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModal: game)
            .preferredColorScheme(.light)
        ContentView(viewModal: game)
            .preferredColorScheme(.dark)
    }
}
