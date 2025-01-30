//
//  RecipeListViewModelTests.swift
//  RecipeAppTests
//
//  Created by Subba Nelakudhiti on 1/28/25.
//

import XCTest
@testable import RecipeApp

final class RecipeListViewModelTests: XCTestCase {
    var sut: RecipeListViewModel!
    var mockServices: MockRecipeService!

    override func setUp() {
        super.setUp()
        mockServices = MockRecipeService()
        sut = RecipeListViewModel(recipeService: mockServices)
    }

    override func tearDown() {
        mockServices = nil
        sut = nil
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testFetchRecipes() async {
        mockServices.input = .success
        XCTAssertTrue(sut.recipes.isEmpty)
        XCTAssertTrue(sut.errorMessage.isEmpty)
        XCTAssertEqual(sut.state, .fetching)

        await sut.loadRecipes()

        XCTAssertFalse(sut.recipes.isEmpty)
        XCTAssertEqual(sut.recipes.count, 1)
        XCTAssertEqual(sut.cuisines.count, 2)
        XCTAssertEqual(sut.filteredRecipes.count, 1)
        XCTAssertTrue(sut.errorMessage.isEmpty)
        XCTAssertEqual(sut.state, .idle)
    }

    @MainActor func testFetchRecipesFailure() async {
        mockServices.input = .failure
        XCTAssertTrue(sut.recipes.isEmpty)
        XCTAssertTrue(sut.errorMessage.isEmpty)
        XCTAssertEqual(sut.state, .fetching)

        await sut.loadRecipes()

        XCTAssertTrue(sut.recipes.isEmpty)
        XCTAssertEqual(sut.recipes.count, 0)
        XCTAssertEqual(sut.cuisines.count, 1)
        XCTAssertEqual(sut.filteredRecipes.count, 0)
        XCTAssertNotEqual(sut.errorMessage, "")
        XCTAssertEqual(sut.state, .idle)
    }

    @MainActor func testFilterdRecipe() async {
        mockServices.input = .success
        await sut.loadRecipes()

        XCTAssertFalse(sut.recipes.isEmpty)
        XCTAssertEqual(sut.recipes.count, 1)
        XCTAssertEqual(sut.filteredRecipes.count, 1)

        sut.selectedCuisine = "Italian"
        sut.filteredRecipes = sut.getFilteredRecipes()
        XCTAssertEqual(sut.filteredRecipes.count, 0)

        sut.selectedCuisine = "All"
        sut.filteredRecipes = sut.getFilteredRecipes()
        XCTAssertEqual(sut.filteredRecipes.count, 1)

        sut.selectedCuisine = "Malaysian"
        sut.filteredRecipes = sut.getFilteredRecipes()
        XCTAssertEqual(sut.filteredRecipes.count, 1)
    }
}
