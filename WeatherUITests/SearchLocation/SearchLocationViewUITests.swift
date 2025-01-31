//
//  SearchLocationViewUITests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 31/01/25.
//

@testable import Weather
import XCTest
import SwiftUI

final class SearchLocationViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchLocationView = app.otherElements["searchLocationView"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchLocationView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchLocationView.exists)
    }

    @MainActor
    func testSearchTextfieldIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchLocationView = app.otherElements["searchLocationView"]
        let searchTextField = app.textFields["searchLocationTextfield"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchLocationView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchLocationView.exists)
        XCTAssertTrue(searchTextField.exists)
    }

    @MainActor
    func testEmptyViewElements() {
        let app = XCUIApplication()
        app.launch()

        let searchLocationView = app.otherElements["searchLocationView"]
        let emptyViewImage = app.images["location"]
        let emptyViewTitle = app.staticTexts["Search for your favorite location and you will find details about its weather status."]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchLocationView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewImage, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewTitle, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchLocationView.exists)
        XCTAssertTrue(emptyViewImage.exists)
        XCTAssertTrue(emptyViewTitle.exists)
    }

    @MainActor
    func testListViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchLocationView = app.otherElements["searchLocationView"]
        let searchTextField = app.textFields["searchLocationTextfield"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchLocationView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("San Francisco")

        let listView = app.collectionViews["searchLocationListView"]

        expectation(for: existsPredicate, evaluatedWith: listView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(listView.exists)
    }
}
