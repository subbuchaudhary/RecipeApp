//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import Foundation

protocol RecipeProtocol {
    func fetchRecipes() async throws -> RecipeDataModel
}

struct RecipeService: APIManager, RecipeProtocol {
    func fetchRecipes() async throws -> RecipeDataModel {
        return try await fetchData(from: RecipeEndpoint.recipes, responseModel: RecipeDataModel.self)
    }
}
