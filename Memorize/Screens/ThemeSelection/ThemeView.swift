import SwiftUI

struct ThemeView: View {
    @ObservedObject var viewModel: ThemeSelectionViewModel
    let colorAdapter: ColorAdapter

    var body: some View {
        NavigationView {
            List(viewModel.themes) { theme in
                ScrollView {
                    NavigationLink(destination: GameView(viewModel: GameViewModel(theme: theme, allAvailableThemes: viewModel.themes))) {
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
                leading: Button(action: {
                    viewModel.themes.append(ThemeModel(
                        name: "New theme",
                        numOfPairs: .random,
                        emojis: ["🎄", "🍄", "🦙", "🦔", "🍃", "🌴"],
                        color: "pink"
                    ))
                }, label: {
                    Image(systemName: "plus")
                }),
                trailing: Button(action: {
                    debugPrint("Edit a theme")
                }, label: {
                    Text("Edit")
                })
            )
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(
            viewModel: ThemeSelectionViewModel(),
            colorAdapter: ColorAdapter()
        )
    }
}
