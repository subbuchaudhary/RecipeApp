//
//  MockNetworkManager.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/28/25.
//

import XCTest
@testable import RecipeApp

final class MockRecipeService: RecipeProtocol {

    enum Input {
        case failure
        case success
    }
    
    var input: Input
    
    init(input: Input) {
        self.input = input
    }

    func fetchRecipes() async throws -> RecipeApp.RecipeDataModel {
        if input == .success {
            return RecipeDataModel(recipes: [Recipe.mockRecipe])
        } else {
            throw APIError.invalidURL
        }
    }
}
