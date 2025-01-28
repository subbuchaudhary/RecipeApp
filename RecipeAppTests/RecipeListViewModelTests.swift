//
//  RecipeListViewModelTests.swift
//  RecipeAppTests
//
//  Created by Subba Nelakudhiti on 1/28/25.
//

import XCTest
@testable import RecipeApp

final class RecipeListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testFetchRecipes() async {
        let viewModel = RecipeListViewModel(apiManager: MockNetworkManager(input: .success))
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssert(viewModel.errorMessage == "")
        XCTAssert(viewModel.state == .idle)

        await viewModel.loadRecipes()

        XCTAssertFalse(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.cuisines.count, 2)
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
        XCTAssert(viewModel.errorMessage == "")
        XCTAssert(viewModel.state == .idle)
    }

    @MainActor func testFetchRecipesFailure() async {
        let viewModel = RecipeListViewModel(apiManager: MockNetworkManager(input: .failure))
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssert(viewModel.errorMessage == "")
        XCTAssert(viewModel.state == .idle)

        await viewModel.loadRecipes()

        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.cuisines.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)
        XCTAssert(viewModel.errorMessage != "")
        XCTAssert(viewModel.state == .idle)
    }

    @MainActor func testFilterdRecipe() async {
        let viewModel = RecipeListViewModel(apiManager: MockNetworkManager(input: .success))
        await viewModel.loadRecipes()

        XCTAssertFalse(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)

        viewModel.selectedCuisine = "Italian"
        viewModel.filteredRecipes = viewModel.getFilteredRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)

        viewModel.selectedCuisine = "All"
        viewModel.filteredRecipes = viewModel.getFilteredRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)

        viewModel.selectedCuisine = "Malaysian"
        viewModel.filteredRecipes = viewModel.getFilteredRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
    }
}
