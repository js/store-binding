import Foundation

/// A "compact" representation of a Recipe, without all attributes,
/// coming from some external place like a webservice
struct CompactRecipe: Hashable, Equatable, Identifiable {
    var id: String
    var title: String
    var isFavorite: Bool
}

/// A full representation of a Recipe, coming from some remote service
struct FullRecipe: Hashable, Equatable, Identifiable {
    var id: String
    var title: String
    var description: String
    var isFavorite: Bool
}

struct RecipeService {
    func fetchList() async throws -> [CompactRecipe] {
        try await Task.sleep(for: .milliseconds(600))

        return (0...25).map {
            CompactRecipe(id: "\($0)", title: "Recipe #\($0)", isFavorite: false)
        }
    }

    func fetchFullRecipe(id: Recipe.ID) async throws -> FullRecipe {
        try await Task.sleep(for: .milliseconds(600))

        return FullRecipe(id: "\(id)", title: "Recipe #\(id) (full)", description: "Recipe number \(id)", isFavorite: false)
    }
}
