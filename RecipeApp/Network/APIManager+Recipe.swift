//
//  APIManager+Recipe.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import Foundation

protocol RecipeProtocol {
    func fetchRecipes() async throws -> RecipeDataModel
}

extension APIManager: RecipeProtocol {
    func fetchRecipes() async throws -> RecipeDataModel {
        return try await fetchData(from: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    }
}
