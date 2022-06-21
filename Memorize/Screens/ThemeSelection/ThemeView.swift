import SwiftUI

struct ThemeView: View {
    let theme = ThemeSelectionViewModel().themes

    var body: some View {
        NavigationView {
            List(theme) { theme in
                NavigationLink(destination: GameView(viewModel: GameViewModel(theme: theme))) {
                    VStack(alignment: .leading) {
                        Text(theme.name)
                            .foregroundColor(ThemeSelectionViewModel.convertColor(color: theme.color))
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
            .listStyle(.plain)
            .navigationBarTitle(Text("Memorize"))
        }
    }
}



//struct ThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeView()
//    }
//}
