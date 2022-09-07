import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var viewModel: ThemeChooserViewModel
    @State private var editMode: EditMode = .inactive
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
                                ForEach(Set(theme.emojis).sorted(), id: \.self) { emoji in
                                    Text(emoji)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                .onDelete { index in
                    viewModel.themes.remove(atOffsets: index)
                }
                .onMove { index, newOffset in
                    viewModel.themes.move(fromOffsets: index, toOffset: newOffset)
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
}
