# Binding to a Store

This sample code shows a simplified example on how to bind values into a Store like pattern. The store is also updated with external data, such as from a webservice.

The list of recipes fetches "partial" recipes, and the detail view fetches the full recipe both updating the store as they go. An important separation here is between our local domain object which is the `Recipe` and the service/backend domain objects being the `CompactRecipe`+`FullRecipe` simulating a situation where your list API only returns part of the object and then you fetch the full object in the detail view.

## Overview

The List ForEach in the ContentView creates the bindings for the items through via the [$binding syntax](1)

The child views (the detail and edit) views uses a Binding<Recipe> into the recipes present in the store, external changes (eg data from backend service) is then placed into the store, which in turn makes the bindings update

## Things which are not interesting here

Things the sample doesn't show or care about

### Dependency injection

The sample happens to use environmentObject(), but could be through the initializers or any other way dependency injection you may favor

### Architectural layers

The communication and coordination between the Store and the RecipeService is done in the SwiftUI View layer, put it in a view model or some other layer that makes sense for your app.

### Editing

Editing a recipe updates the binding directly. In a real situation you'd typically write the changes to a backend and then update your binding (eg the recipe in the Store) once that succeeds. That would also allow cancelling the edit and discarding any changes.


### Loading and failure state

You know you need to.

[1]: https://peterfriese.dev/posts/swiftui-list-item-bindings-behind-the-scenes/ 