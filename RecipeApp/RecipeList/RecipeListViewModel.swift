//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import Combine
import Foundation

enum FetchableState {
    case fetching
    case idle
}

final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var selectedCuisine: String = "All"
    @Published var shouldShowAlert: Bool = false
    
    var errorMessage: String = ""
    let title: String = "Recipe App"
    let noRecipesMessage: String = "No recipes are available"

    private(set) var state: FetchableState = .fetching
    private let apiManager: RecipeProtocol

    init(apiManager: RecipeProtocol = RecipeService()) {
        self.apiManager = apiManager
    }

    @MainActor
    func loadRecipes() {
        state = .fetching
        Task {
            do {
                let dataModel = try await apiManager.fetchRecipes()
                recipes = dataModel.recipes
                filteredRecipes = getFilteredRecipes()
                state = .idle
                shouldShowAlert = false
            } catch {
                self.errorMessage = error.localizedDescription
                state = .idle
                shouldShowAlert = true
            }
        }
    }

    var cuisines: [String] {
        var array = Array(Set(recipes.map { $0.cuisine }))
        array.insert("All", at: 0)
        return array
    }

    func getFilteredRecipes() -> [Recipe] {
        if selectedCuisine == "All" {
            return recipes
        }
        return recipes.filter { $0.cuisine.lowercased() == selectedCuisine.lowercased() }
    }
}
