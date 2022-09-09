import SwiftUI

struct ThemeEditorView: View {
    var viewModel: ThemeEditorViewModel
    @State private var emojisToAdd = ""
    @State var pairsValue: String

    init(theme: ThemeEditorViewModel, pairsValue: ThemeModel.NumOfPairs) {
        var value: String {
            if pairsValue == .all {
                return "All"
            } else if pairsValue == .random {
                return "Random"
            } else {
                return "Explicit"
            }
        }

        self.viewModel = theme
        self.pairsValue = value
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
            TextField("Name", text: viewModel.$theme.name)
        }
    }

    var addEmojiSection: some View {
        Section(header: Text("Add emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { newEmoji in
                    viewModel.add(newEmoji.last ?? nil)
                }
        }
    }

    var removeEmojiSection: some View {
        Section(header: Text("Remove emojis")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(viewModel.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            viewModel.remove(emoji)
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
                    Picker(selection: $pairsValue) {
                        let numberCases = ["All", "Random", "Explicit"]
                        ForEach(numberCases, id: \.self) { numCase in
                            Text("\(numCase)")
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: pairsValue) { newValue in
                        viewModel.updatePairs(newValue)
                    }
                }

                if pairsValue == "Explicit" {
                    var count = viewModel.pairsCount()

                    Stepper("\(count) pairs") {
                        count += 1
                        viewModel.incrementPairsCount(count)
                    } onDecrement: {
                        if count != 0 {
                            count -= 1
                            viewModel.decrementPairsCount(count)
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
