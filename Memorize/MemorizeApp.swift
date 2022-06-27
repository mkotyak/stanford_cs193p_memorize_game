import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeView(
                viewModel: ThemeSelectionViewModel(),
                colorAdapter: ColorAdapter()
            )
        }
    }
}
