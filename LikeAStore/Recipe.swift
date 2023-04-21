import Foundation

// App specific domain model
struct Recipe: Hashable, Equatable, Identifiable {
    var id: String
    var title: String
    var description: String?
    /// is the recipe favorited by the current user
    var isFavorite: Bool

    mutating func update(with compactRecipe: CompactRecipe) {
        title = compactRecipe.title
        //isFavorite = compactRecipe.isFavorite
    }

    mutating func update(with fullRecipe: FullRecipe) {
        title = fullRecipe.title
        description = fullRecipe.description
        //isFavorite = fullRecipe.isFavorite
    }
}
