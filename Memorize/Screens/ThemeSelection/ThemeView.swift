import SwiftUI

struct ThemeView: View {
    @ObservedObject var viewModel: ThemeSelectionViewModel
    let colorAdapter: ColorAdapter

    var body: some View {
        NavigationView {
            List(viewModel.themes) { theme in
                ScrollView {
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
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Memorize"))
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
                leading: newThemeButton,
                trailing: editThemeButton
            )
        }
    }

    private var newThemeButton: some View {
        Button(action: {
            viewModel.themes.append(ThemeModel(
                name: "New theme",
                numOfPairs: .random,
                emojis: ["🎄", "🍄", "🦙", "🦔", "🍃", "🌴"],
                color: "pink"
            ))
        }, label: {
            Image(systemName: "plus")
        })
    }

    private var editThemeButton: some View {
        Button(action: {
            debugPrint("Edit a theme")
        }, label: {
            Text("Edit")
        })
    }
}
