//
//  MoviesViewControllerUITests.swift
//  MoviesUITests
//
//  Created by Pedro on 28-07-24.
//

import XCTest

final class MoviesViewControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func testShowsActivityIndicator() {
        // Act
        app.launch()

        // Assert
        let activityIndicator = app.activityIndicators["activityIndicator"]
        XCTAssert(activityIndicator.exists)
    }

    func testRetryButtonFlow() {
        // Arrange
        app.launchArguments.append("fail_once")

        // Act
        app.launch()

        let activityIndicator = app.activityIndicators.firstMatch
        XCTAssert(activityIndicator.exists)

        let retryButton = app.buttons["retryButton"]
        XCTAssert(retryButton.waitForExistence(timeout: 5))

        retryButton.tap()

        // Assert
        let collectionView = app.collectionViews.firstMatch
        XCTAssert(collectionView.waitForExistence(timeout: 5))
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
}
