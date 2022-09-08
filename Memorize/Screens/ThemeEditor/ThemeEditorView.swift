import SwiftUI

struct ThemeEditorView: View {
    var theme: ThemeEditorViewModel
    @State private var emojisToAdd = ""

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
            HStack {
                Text("Num of pairs")
                Stepper("") {} onDecrement: {}
            }
        }
    }

    var colorSection: some View {
        Section(header: Text("Color")) {
        }
    }
}
