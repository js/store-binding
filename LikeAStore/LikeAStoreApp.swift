import SwiftUI

@main
struct LikeAStoreApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(RecipeStore())
        }
    }
}
