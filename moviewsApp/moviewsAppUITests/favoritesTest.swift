//
//  favoritesTest.swift
//  moviewsAppUITests
//
//  Created by carlos jaramillo on 9/4/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import XCTest

class favoritesTest: XCTestCase {
    
    let app = XCUIApplication()
    
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
    
    
    /// test que se dirije a la pantalla de favoritos y elimina de los favoritos la primera pelicula de la lista
    func testDeleteFavoriteMovie() {
        if self.goToFavorites(){
            let table = app.tables
            let cell = table.children(matching: .any).element(boundBy : 0)
            if cell.exists{
                cell.swipeLeft()
                table.buttons["UNFAVORITE"].tap()
            }
        }
    }
    
    
    /// test que aplica filtros sobre las peliculas favoritas seleccionanado la primera opcion en el anio y en el genero , y posteriormente los remueve
    func testFilterCells(){
        
        
        if self.goToFavorites(){
            let app = XCUIApplication()
            app.navigationBars["Favorites"].buttons["Item"].tap()
            let dateArrawButton = app.tables.cells.containing(.staticText, identifier:"Date").images["arrow-right"]
            if dateArrawButton.exists && dateArrawButton.isHittable{
                dateArrawButton.tap()
                let table = app.tables
                let cell = table.children(matching: .any).element(boundBy : 0)
                let leftArrowButton = app.navigationBars["Filter"].buttons["left arrow"]
                if cell.exists{
                    cell.tap()
                    leftArrowButton.tap()
                }
                let genreArrawButton = app.tables.cells.containing(.staticText, identifier:"Genres").images["arrow-right"]
                if genreArrawButton.exists && genreArrawButton.isHittable{
                    genreArrawButton.tap()
                    let table = app.tables
                    let cell = table.children(matching: .any).element(boundBy : 0)
                    if cell.exists{
                        cell.tap()
                        leftArrowButton.tap()
                    }
                    app.buttons["Apply"].tap()
                    sleep(2)
                    app.buttons["REMOVE FILTERS"].tap()
                }
            }
        }
    }
    
    
    /// dirije a la pantalla de favoritos
    ///
    /// - Returns: devuelve true si fue exitoso o no
    func goToFavorites() -> Bool{
        let tabBars = app.tabBars
        if tabBars.element.exists && tabBars.element.isHittable{
            let favoriteButtonTabBar = tabBars.buttons["favorites"]
            if favoriteButtonTabBar.exists && favoriteButtonTabBar.isHittable{
                favoriteButtonTabBar.tap()
                return true
            }
        }
        return false
    }
}
