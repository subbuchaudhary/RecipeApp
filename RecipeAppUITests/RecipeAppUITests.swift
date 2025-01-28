//
//  RecipeAppUITests.swift
//  RecipeAppUITests
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import XCTest

final class RecipeAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testRecipeAndFilterHappyPath() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars.element(matching: .any, identifier: "Recipe App").waitForExistence(timeout: 10), "Recipe App navigation bar is not displayed")

        // Verify cell element
        let cell = app.cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 5))

        XCTAssertTrue(cell.images.element(matching: .image, identifier: "RecipeCell.Image").exists, "RecipeCell.Image is not displayed")
        XCTAssertTrue(cell.staticTexts.element(matching: .staticText, identifier: "RecipeCell.RecipeName").exists, "RecipeCell.RecipeName is not displayed")
        XCTAssertTrue(cell.staticTexts.element(matching: .staticText, identifier: "RecipeCell.CuisineName").exists, "RecipeCell.CuisineName is not displayed")

        // Verify details page
        cell.firstMatch.tap()

        XCTAssertTrue(app.images.element(matching: .image, identifier: "Details.Image").exists, "Details.Image is not displayed")
        XCTAssertTrue(app.staticTexts.element(matching: .staticText, identifier: "Details.Recipe").exists, "Details.Recipe is not displayed")
        XCTAssertTrue(app.staticTexts.element(matching: .staticText, identifier: "Details.Cuisine").exists, "Details.Cuisine is not displayed")

        let backButton = app.buttons.element(matching: NSPredicate(format: "label CONTAINS 'Recipe App'"))
        backButton.firstMatch.tap()
        XCTAssertTrue(app.navigationBars.element(matching: .any, identifier: "Recipe App").waitForExistence(timeout: 10), "Back button is not displayed")

        // Verify Filter page
        let filterButton = app.otherElements.element(matching: NSPredicate(format: "label CONTAINS 'Filter'"))
        XCTAssertTrue(filterButton.exists, "Filter button is not displayed")
        filterButton.tap()

        XCTAssertTrue(app.navigationBars.element(matching: .any, identifier: "Select Cuisine").waitForExistence(timeout: 10), "Select Cuisine is not displayed")
        let filterCell = app.cells.firstMatch
        XCTAssertTrue(filterCell.waitForExistence(timeout: 5))
        let closeButton = app.otherElements.element(matching: NSPredicate(format: "label CONTAINS 'Close'"))
        closeButton.firstMatch.tap()

        // Verify Home page
        XCTAssertTrue(app.navigationBars.element(matching: .any, identifier: "Recipe App").waitForExistence(timeout: 10), "Recipe App is not displayed")
    }


    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
