import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: ThemeModel
    @State private var emojisToAdd = ""

    var body: some View {
        Form {
            nameSection
            addEmojiSection
            removeEmojiSection
//            cardCountSection
//            colorSection
        }
    }

    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }

    var addEmojiSection: some View {
        Section(header: Text("Add emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { newEmoji in
                    add(newEmoji.last ?? nil)
                }
        }
    }

    var removeEmojiSection: some View {
        Section(header: Text("Remove emojis")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            remove(emoji)
                        }
                }
            }
            .font(.system(size: 40))
        }
    }

//    var cardCountSection: some View {}
//
//    var colorSection: some View {}

    private func add(_ emoji: Character?) {
        guard let emoji = emoji else {
            return
        }

        guard emoji.isEmoji,
              !theme.emojis.contains(String(emoji))
        else {
            return
        }

        theme.emojis.insert(String(emoji), at: 0)
    }

    private func remove(_ emoji: String) {
        if let index = theme.emojis.firstIndex(where: { $0.hashValue == emoji.hashValue }) {
            theme.emojis.remove(at: index)
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeChooserViewModel().themes[0]))
    }
}
