import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var viewModel: ThemeChooserViewModel
    @State private var editMode: EditMode = .inactive
    @State private var isManaging = false
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
                            Text(viewModel.subtitle(for: theme))
                                .lineLimit(1)
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
                    ThemeEditorView(theme: ThemeEditorViewModel(theme: $viewModel.themes[index]), pairs: viewModel.themes[index].numOfPairs)
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
                numOfPairs: .all,
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
                isManaging = true
                themeToEdit = theme
            }
    }
}
