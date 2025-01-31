//
//  FavoritesLocationsViewUITests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 31/01/25.
//

@testable import Weather
import XCTest

final class FavoritesLocationsViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let favoritesTab = app.tabBars.buttons["Favorites"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: favoritesTab, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(favoritesTab.exists)
        favoritesTab.tap()

        let searchLocationView = app.otherElements["favoriteLocationsView"]

        expectation(for: existsPredicate, evaluatedWith: searchLocationView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchLocationView.exists)
    }

    @MainActor
    func testEmptyViewElements() {
        let app = XCUIApplication()
        app.launch()

        let favoritesTab = app.tabBars.buttons["Favorites"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: favoritesTab, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(favoritesTab.exists)
        favoritesTab.tap()

        let searchLocationView = app.otherElements["favoriteLocationsView"]
        let emptyViewTitle = app.staticTexts["No favorites yet"]
        let emptyViewMessage = app.staticTexts["Add your favorite locations to see the weather forecast."]

        expectation(for: existsPredicate, evaluatedWith: searchLocationView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewTitle, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewMessage, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchLocationView.exists)
        XCTAssertTrue(emptyViewTitle.exists)
        XCTAssertTrue(emptyViewMessage.exists)
    }
}
