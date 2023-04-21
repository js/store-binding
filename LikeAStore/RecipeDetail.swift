import SwiftUI

struct RecipeDetail: View {
    @Binding var recipe: Recipe

    @State private var isPresentingEditor = false
    @EnvironmentObject private var store: RecipeStore
    // Since we never write the edited recipe to a backendserver, we only do the "fetch" once
    // but it will erase any previous edits since the changes are never persisted through the service.
    // eg simplification for the sake of this sample code.
    @State private var isFirstAppear = true
    private let service = RecipeService()

    var body: some View {
        VStack {
            HStack {
                Text(recipe.title)
                Spacer()
                Button {
                    recipe.isFavorite.toggle()
                } label: {
                    Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                }
            }
            .font(.title)

            Text(recipe.description ?? "")

            Spacer()
        }
        .toolbar {
            Button("Edit") {
                isPresentingEditor = true
            }
        }
        .padding()
        .sheet(isPresented: $isPresentingEditor) {
            EditRecipeView(recipe: $recipe)
        }
        .task {
            await fetchDetails()
        }
    }

    private func fetchDetails() async {
        guard isFirstAppear else { return }

        do {
            // Typically you'd want to lift this up a level, say into to a viewmodel or perhaps even better a view model (or not) that
            // communicates with some other object responsible for fetching and storing.
            let update = try await service.fetchFullRecipe(id: recipe.id)
            // Merge the full recipes we fetched into the store. Since we bound our `recipe` to what is in the store
            // the changes will be reflected here through the Binding
            store.merge(fullRecipe: update)
        } catch {
            // ..
        }

        isFirstAppear = false
    }
}
