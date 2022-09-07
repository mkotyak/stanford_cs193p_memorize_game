import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeChooser(
                viewModel: ThemeChooserViewModel(),
                colorAdapter: ColorAdapter()
            )
        }
    }
}
