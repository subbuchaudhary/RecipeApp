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
    @Published var shouldShowAlert: Bool = false
    var errorMessage: String = ""
    let title: String = "Recipe App"

    private(set) var state: FetchableState = .idle
    private let apiManager: RecipeProtocol

    init(apiManager: RecipeProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }

    @MainActor
    func loadRecipes() {
        state = .fetching
        Task {
            do {
                let dataModel = try await apiManager.fetchRecipes()
                recipes = dataModel.recipes
                state = .idle
                shouldShowAlert = false
            } catch {
                self.errorMessage = error.localizedDescription
                state = .idle
                shouldShowAlert = true
            }
        }
    }
}
