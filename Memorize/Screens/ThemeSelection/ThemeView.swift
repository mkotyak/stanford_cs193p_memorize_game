import SwiftUI

struct ThemeView: View {
    @ObservedObject var viewModel: ThemeSelectionViewModel

    var body: some View {
        NavigationView {
            List(viewModel.themes) { theme in
                ScrollView {
                    NavigationLink(destination: GameView(viewModel: GameViewModel(theme: theme, allAvailableThemes: viewModel.themes))) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .foregroundColor(viewModel.convertColor(color: theme.color))
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
        }
    }
}
