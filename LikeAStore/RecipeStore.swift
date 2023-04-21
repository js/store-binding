import Foundation

final class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe] = []
}

/// Store seeding, could also be actions which are reduced into store changes redux style
extension RecipeStore {
    @MainActor
    func initial(recipes: [Recipe]) {
        self.recipes = recipes
    }

    @MainActor
    func merge(compactRecipe: CompactRecipe) {
        guard let index = recipes.firstIndex(where: { $0.id == compactRecipe.id }) else {
            recipes.append(Recipe(id: compactRecipe.id, title: compactRecipe.title, description: nil, isFavorite: compactRecipe.isFavorite))
            return
        }

        var recipe = recipes[index]
        recipe.update(with: compactRecipe)
        recipes[index] = recipe
    }

    @MainActor
    func merge(fullRecipe: FullRecipe) {
        guard let index = recipes.firstIndex(where: { $0.id == fullRecipe.id }) else {
            recipes.append(Recipe(id: fullRecipe.id, title: fullRecipe.title, description: fullRecipe.description, isFavorite: fullRecipe.isFavorite))
            return
        }

        var recipe = recipes[index]
        recipe.update(with: fullRecipe)
        recipes[index] = recipe
    }
}
