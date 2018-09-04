//
//  moviewsAppUITests.swift
//  moviewsAppUITests
//
//  Created by carlos jaramillo on 8/29/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import XCTest

class homeTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// test para probar la paginacion de las peliculas populares y buscadas
    func testPagination() {
        let app = XCUIApplication()
        let collectionView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element
        
        if collectionView.exists && collectionView.isHittable{
            collectionView.swipeUp()
            collectionView.swipeUp()
            collectionView.swipeUp()
            collectionView.swipeUp()
            collectionView.swipeUp()
            collectionView.swipeUp()
            collectionView.swipeUp()
        }
    }
    
    ///test sobre la pelicula Vengadores : Infinity War la abre y la cierra
    func testOpenMovies(){
        
        let app = XCUIApplication()
        let collectionView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element
        if collectionView.cells.otherElements.containing(.staticText, identifier:"Vengadores: Infinity War").element.exists{
            collectionView.cells.otherElements.containing(.staticText, identifier:"Vengadores: Infinity War").element.tap()
            let backButton = app.navigationBars["Vengadores: Infinity War"].buttons["Movies"]
            if backButton.exists{
                backButton.tap()
            }
        }
    }
    
    
    /// test sobre la pelicula Vengadores : Infinity War prueba el boton de la celda para agregar y quitar de favoritos
    func testAppendAndRemoveToFavorites(){
        
        let app = XCUIApplication()
        let collectionView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element

        let favoriteButton = collectionView.cells.otherElements.containing(.staticText, identifier:"Vengadores: Infinity War").buttons["favorite"]
        if favoriteButton.exists && favoriteButton.isHittable{
            favoriteButton.tap()
        }
        else{
            return
        }
        
        let tabBars = app.tabBars
        if tabBars.element.exists && tabBars.element.isHittable{
            let favoriteButtonTabBar = tabBars.buttons["favorites"]
            let moviesButtonTabBar = tabBars.buttons["Movies"]
            if favoriteButtonTabBar.exists && favoriteButtonTabBar.isHittable && moviesButtonTabBar.exists && moviesButtonTabBar.isHittable{
                favoriteButtonTabBar.tap()
                sleep(3)
                moviesButtonTabBar.tap()
            }
        }
        
    }
    
}
