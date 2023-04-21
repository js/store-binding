import SwiftUI

struct EditRecipeView: View {
    // We edit the Recipe directly through the binding. In the real world we'd probably shadow this (eg edit a copy),
    // save that to our abckend, and then update the binding before dismissing.
    // Or pass in a Editor/Configuration that informs our parent about these changes if we want to keep this view dumb
    @Binding var recipe: Recipe

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section("Edit Recipe") {
                    TextField("Title", text: $recipe.title)

                    TextField("Description", text: $recipe.description)
                }
            }
            .padding()
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
//
//struct EditRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecipeView()
//    }
//}
//
