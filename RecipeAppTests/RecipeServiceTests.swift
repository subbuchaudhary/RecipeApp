//
//  RecipeServiceTests.swift
//  RecipeAppTests
//
//  Created by Subba Nelakudhiti on 1/30/25.
//

import XCTest
@testable import RecipeApp

final class RecipeServiceTests: XCTestCase {
    var sut: RecipeProtocol!
    var mockServices: MockRecipeService!
    var recipes: [Recipe]!

    override func setUp() {
        super.setUp()
        mockServices = MockRecipeService()
        sut = mockServices
        recipes = []
    }

    override func tearDown() {
        mockServices = nil
        sut = nil
        recipes = nil
        super.tearDown()
    }

    func testFetchRecipesMock() async throws {
        // Given
        mockServices.input = .success

        // When
        let result = try await sut.fetchRecipes()
        recipes = result.recipes
        XCTAssertNotNil(recipes)
    }

    func testFetchRecipesFailure() async throws {
        // Given
        mockServices.input = .failure
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }
        let expectation = expectation(description: "API call should throw invalid URL message")

        // When
        Task {
            do {
                let result = try await sut.fetchRecipes()
                recipes = result.recipes
            } catch let error as APIError {
                errorHandler(error)
            }
            expectation.fulfill()
        }

        await fulfillment(of: [expectation])

        // Then
        XCTAssertEqual(thrownError as! APIError, APIError.invalidURL)
        XCTAssertTrue(recipes.isEmpty)
    }

}
