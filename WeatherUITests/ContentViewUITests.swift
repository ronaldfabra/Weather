//
//  ContentViewUITests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 31/01/25.
//

@testable import Weather
import XCTest

final class ContentViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testSplashViewIsVisibleInitially() {
        let app = XCUIApplication()
        app.launch()

        let splashView = app.otherElements["splashView"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: splashView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(splashView.exists)
    }

    @MainActor
    func testTabViewAppearsAfterDelay() {
        let app = XCUIApplication()
        app.launch()

        let tabView = app.otherElements["tabView"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: tabView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(tabView.exists)
    }
}
