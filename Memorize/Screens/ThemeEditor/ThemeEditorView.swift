import SwiftUI

struct ThemeEditorView: View {
    var theme: ThemeEditorViewModel
    @State private var emojisToAdd = ""
    @State var pairs: String

    init(theme: ThemeEditorViewModel, pairs: ThemeModel.NumOfPairs) {
        var num: String {
            if pairs == .all {
                return "All"
            } else if pairs == .random {
                return "Random"
            } else {
                return "Explicit"
            }
        }

        self.theme = theme
        self.pairs = num
    }

    var body: some View {
        Form {
            nameSection
            addEmojiSection
            removeEmojiSection
            cardCountSection
            colorSection
        }
    }

    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: theme.$theme.name)
        }
    }

    var addEmojiSection: some View {
        Section(header: Text("Add emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { newEmoji in
                    theme.add(newEmoji.last ?? nil)
                }
        }
    }

    var removeEmojiSection: some View {
        Section(header: Text("Remove emojis")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            theme.remove(emoji)
                        }
                }
            }
            .font(.system(size: 40))
        }
    }

    var cardCountSection: some View {
        Section(header: Text("Card count")) {
            VStack {
                HStack {
                    Picker(selection: $pairs) {
                        let numberCases = ["All", "Random", "Explicit"]
                        ForEach(numberCases, id: \.self) { numCase in
                            Text("\(numCase)")
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: pairs) { newValue in
                        theme.updatePairs(newValue)
                    }
                }

                if pairs == "Explicit" {
                    var count = theme.pairsCount()

                    Stepper("\(count) pairs") {
                        count += 1
                        theme.incrementPairsCount(count)
                    } onDecrement: {
                        if count != 0 {
                            count -= 1
                            theme.decrementPairsCount(count)
                        }
                    }
                }
            }
        }
    }

    var colorSection: some View {
        Section(header: Text("Color")) {}
    }
}
