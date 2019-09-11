//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import XCTest

class MovieDBUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddFavorite() {
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 1)/*@START_MENU_TOKEN@*/.buttons["favorite full icon"]/*[[".cells.buttons[\"favorite full icon\"]",".buttons[\"favorite full icon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testSearch() {
        let app = XCUIApplication()
        app.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("Chapter")

        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .collectionView).element(boundBy: 1)/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"It Chapter Two")/*[[".cells.containing(.button, identifier:\"favorite full icon\")",".cells.containing(.staticText, identifier:\"It Chapter Two\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
    }

    func testDetailMovie() {
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 1)/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"It Chapter Two")/*[[".cells.containing(.button, identifier:\"favorite full icon\")",".cells.containing(.staticText, identifier:\"It Chapter Two\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
    }

    func testViewFavorites() {
        let app = XCUIApplication()
        app.tabBars.buttons["Favorites"].tap()
    }

    func testDeleteFavorite() {
        let app = XCUIApplication()

        let window = app.children(matching: .window).collectionViews
        window.children(matching: .button).element(boundBy: 0).tap()

        app.tabBars.buttons["Favorites"].tap()
        let tablesQuery = app.tables
        tablesQuery.cells.element(boundBy: 0).swipeLeft()
        tablesQuery.buttons["Unfavorite"].tap()

        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 3).cells.containing(.staticText, identifier:"Dark Phoenix").buttons["favorite gray icon"].tap()


//        →Application, pid: 15333, label: 'MovieDB'
//        ↳Window (Main)
//        ↳Other
//        ↳Other
//        ↳Other
//        ↳Other
//        ↳Other
//        ↳Other
//        ↳Other
//        ↳CollectionView
//        ↳Cell
//        ⋅ ↳Button, label: 'favorite gray icon'
//        ↳Cell
//        ⋅ ↳Button, label: 'favorite gray icon'
//        ↳Cell
//        ⋅ ↳Button, label: 'favorite gray icon'
//        ↳Cell
//        ⋅ ↳Button, label: 'favorite gray icon'
//        ↳Cell
//        ⋅ ↳Button, label: 'favorite gray icon'
//        ↳Cell
//        ↳Button, label: 'favorite gray icon'

    }
    
    

}
