//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel = RecipeListViewModel()

    var body: some View {
           NavigationStack {
               ZStack {
                   switch viewModel.state {
                   case .fetching:
                       ProgressView()
                   case .idle:
                       recipeListView
                           .listStyle(.plain)
                   }
               }
               .navigationTitle(viewModel.title)
               .alert(isPresented: $viewModel.shouldShowAlert) {
                   Alert(title: Text("Error"),
                         message: Text(viewModel.errorMessage),
                         dismissButton: .default(Text("OK")))
               }
               .onAppear {
                   viewModel.loadRecipes()
               }
           }
       }

    private var recipeListView: some View {
        List {
            ForEach($viewModel.recipes, id: \.self) { recipe in
                NavigationLink(destination: RecipeDetailsView(recipe: recipe.wrappedValue)) {
                    RecipeCell(recipe: recipe.wrappedValue)
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    RecipeListView()
}
#endif
