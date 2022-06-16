//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Kotyak on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["😄", "☎️", "👑", "🦊", "🌲", "🌖", "⛄️", "🍎", "🍟", "🍿", "⚽️", "💣", "🧸", "❤️", "🎵", "🏳️‍🌈", "🦖", "🔴", "📞", "⛩"]

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(
                        minimum: widthThatBestFits(cardCount: emojis.count),
                        maximum: widthThatBestFits(cardCount: emojis.count)
                    ))
                ]) {
                    ForEach(emojis[0 ..< emojis.count], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2 / 3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            HStack {
                theme1
                Spacer()
                theme2
                Spacer()
                theme3
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

    var theme1: some View {
        Button {
            let defaultEmojis = [
                "✈️", "🚀", "🚙", "🚁", "🏎",
                "🚓", "🛵", "🛴", "🚲", "🛸",
                "🚄", "🛶", "🚗", "🚌", "🚑",
                "🛺", "🚜", "🏍", "🚃", "🚂"
            ]
            setEmojis(defaultEmojis)
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.subheadline)
            }
        }
    }

    var theme2: some View {
        Button {
            let defaultEmojis = [
                "🐹", "🐰", "🦊", "🐻", "🐼",
                "🐨", "🦁", "🐴", "🦖", "🦧",
                "🦫", "🐶", "🐱", "🐭", "🐯",
                "🐮", "🐷", "🐵", "🐺", "🐅"
            ]
            setEmojis(defaultEmojis)
        } label: {
            VStack {
                Image(systemName: "pawprint")
                Text("Animals").font(.subheadline)
            }
        }
    }

    var theme3: some View {
        Button {
            let defaultEmojis = [
                "😃", "🥹", "😆", "😅", "😂",
                "🥲", "😊", "😇", "🙃", "😉",
                "😍", "🥰", "😘", "😋", "🤪",
                "😎", "🤩", "🥳", "😕", "😤"
            ]
            setEmojis(defaultEmojis)
        } label: {
            VStack {
                Image(systemName: "face.smiling")
                Text("Emojies").font(.subheadline)
            }
        }
    }

    func setEmojis(_ baseEmojis: [String]) {
        emojis = Array(baseEmojis.shuffled()[0 ... Int.random(in: 4 ..< baseEmojis.count)])
    }

    func desc(count: Int) -> CGFloat {
        return 55*55 - 4*6*(121 - 358*634 / CGFloat(count))
    }

    func widthThatBestFits(cardCount: Int) -> CGFloat {
        let x1: CGFloat = (-55 + sqrt(desc(count: cardCount))) / 12
        let x2: CGFloat = (-55 - sqrt(desc(count: cardCount))) / 12
        print(x1, x2)
        return (max(x1, x2)*2) - 50 / CGFloat(cardCount)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
