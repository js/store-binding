//
//  ContentView.swift
//  LikeAStore
//
//  Created by Johan Sørensen on 21/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: RecipeStore

    // Since we never write an edited recipe to a backend service, we only do the "fetch" once
    // so local changes are never overwritten. Sample code simplification.
    @State private var isFirstAppear = true

    var body: some View {
        List {
            ForEach($store.recipes) { $recipe in
                NavigationLink {
                    RecipeDetail(recipe: $recipe)
                } label: {
                    RecipeRow(recipe: recipe)
                }
            }
        }
        .padding()
        .task {
            await fetch()
        }
    }

    // Do the fetch in whatever layer is appropiate for your app, be it a viewmodel or some other "controller"-like thing
    private func fetch() async {
        guard isFirstAppear else { return }

        do {
            let service = RecipeService()
            let recipes = try await service.fetchList()
            // Update our store with the fetched recipes
            recipes.forEach(store.merge(compactRecipe:))
        } catch {
            // ..
        }

        isFirstAppear = false
    }
}

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            Text(recipe.title)
                .font(.headline)

            Spacer()
            Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                .font(.callout.monospacedDigit())
        }
        .padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeStore())

        VStack {
            RecipeRow(recipe: Recipe(id: "1", title: "My Recipe", isFavorite: true))
            RecipeRow(recipe: Recipe(id: "2", title: "My Other Recipe", isFavorite: false))
        }
        .padding()
        .environmentObject(RecipeStore())
    }
}
