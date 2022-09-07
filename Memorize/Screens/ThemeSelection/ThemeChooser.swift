import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var viewModel: ThemeChooserViewModel
    @State private var editMode: EditMode = .inactive
    @State private var managing = false
    @State private var themeToEdit: ThemeModel?

    let colorAdapter: ColorAdapter

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.themes) { theme in
                    NavigationLink(destination: GameView(
                        viewModel: GameViewModel(
                            theme: theme,
                            allAvailableThemes: viewModel.themes
                        )
                    )) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .foregroundColor(colorAdapter.convertColor(color: theme.color))
                                .font(.title)
                            HStack {
                                let emojis = theme.emojis.prefix(min(8, theme.emojis.count))
                                ForEach(Set(emojis).sorted(), id: \.self) { emoji in
                                    Text(emoji)
                                        .font(.headline)
                                }
                                if emojis.count < theme.emojis.count {
                                    Text("...")
                                }
                            }
                        }
                        .gesture(editMode == .active ? tap(on: theme) : nil)
                    }
                }
                .onDelete { index in
                    viewModel.themes.remove(atOffsets: index)
                }
                .onMove { index, newOffset in
                    viewModel.themes.move(fromOffsets: index, toOffset: newOffset)
                }
            }
            .popover(item: $themeToEdit) { theme in
                if let index = viewModel.themes.firstIndex(where: { $0.id == theme.id }) {
                    ThemeEditor(theme: $viewModel.themes[index])
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Memorize"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    newThemeButton
                }
            }
            .environment(\.editMode, $editMode)
        }
    }

    private var newThemeButton: some View {
        Button(action: {
            viewModel.themes.append(ThemeModel(
                name: "New",
                numOfPairs: .none,
                emojis: [],
                color: "black"
            ))
        }, label: {
            Image(systemName: "plus")
        })
    }

    private func tap(on theme: ThemeModel) -> some Gesture {
        TapGesture()
            .onEnded { _ in
                managing = true
                themeToEdit = theme
            }
    }
}
