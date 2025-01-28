//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel = RecipeListViewModel()
    @State private var isShowingPopup: Bool = false

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
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter") {
                        isShowingPopup = true
                    }
                }
            }
            .sheet(isPresented: $isShowingPopup) {
                CuisineSelectionView(
                    cuisines: viewModel.cuisines,
                    selectedCuisine: $viewModel.selectedCuisine,
                    isShowingPopup: $isShowingPopup) {
                        viewModel.filteredRecipes = viewModel.getFilteredRecipes()
                    }
            }
            .onAppear {
                Task {
                    await viewModel.loadRecipes()
                }
            }
        }
    }

    private var recipeListView: some View {
        List {
            if $viewModel.recipes.isEmpty {
                Text(viewModel.noRecipesMessage)
            } else {
                ForEach($viewModel.filteredRecipes, id: \.self) { recipe in
                    NavigationLink(
                        destination: RecipeDetailsView(
                            recipe: recipe.wrappedValue)
                    ) {
                        RecipeCell(recipe: recipe.wrappedValue)
                    }
                }
            }
        }
        .refreshable {
            Task {
                await viewModel.loadRecipes()
            }
        }
    }
}

#if DEBUG
    #Preview {
        RecipeListView()
    }
#endif
