//
//  CoreDataTests.swift
//  MovieScopeTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/12/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import XCTest
@testable import MovieScope

//Pruebas para verificar que los modelos se acomodan a las querys de CoreData
//DEBE TENER DATA PRIMERO ANTES DE COMPROBAR ESTAS PRUEBAS
class CoreDataTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Tests for query func, comprueba que todos los modelos de la app este definidos correctamente en coredata y se puedan recuperar independientemente de querys o filtros
    func testDetailModels(){
        let detailResults = DataBaseManager.shared.queryCoreData(MovieDetailModel.self, search: nil)
        XCTAssert(detailResults.count > 0)
    }
    
    func testMediaModels(){
        let mediaVideoResults = DataBaseManager.shared.queryCoreData(MovieVideoModel.self, search: nil)
        XCTAssert(mediaVideoResults.count > 0)
        
        let mediaImagesResults = DataBaseManager.shared.queryCoreData(MovieImagesModel.self, search: nil)
        XCTAssert(mediaImagesResults.count > 0)
        XCTAssert(mediaImagesResults.first?.backdrops.count ?? 0 > 0)
        XCTAssert(mediaImagesResults.first?.posters.count ?? 0 > 0)
    }
    
    func testMovieModel(){
        let movieModelResults = DataBaseManager.shared.queryCoreData(MovieModel.self, search: nil)
        XCTAssert(movieModelResults.count > 0)
    }
    
    func testMovieListModel(){
        let movieListModelResults = DataBaseManager.shared.queryCoreData(MovieListModel.self, search: nil)
        XCTAssert(movieListModelResults.count > 0)
    }
    
    /** QUERY ROUTERS **/
    
    //Se comprueba que la data se recupera correctamente a traves de los query routers
    //DetailRouter
    func testMovieDetailQueryRouter_getMovieDetail(){
        //ID para El rey de los felinos
        let movieTestId = 420818
        let networkRouter = MovieDetailRouter.getDetail(movieId: movieTestId)
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: networkRouter)
        let detailResults = DataBaseManager.shared.queryCoreData(MovieDetailModel.self, search: queryRouter.queryPredicate)
        //Se asegura de que solo recupere un resultado. Se comprueba de que no existan dos peliculas del rey leon en coredata
        XCTAssert(detailResults.count == 1)
        
        guard let findedMovie = detailResults.first else {
            XCTFail("Failed to retrieve movie")
            return
        }
        // Se comprueba que efectivamente es la misma pelicula y la data se almaceno y recupero correctamente
        XCTAssert(findedMovie.id == movieTestId)
    }
    
    func testMovieDetailQueryRouter_getMovieImages(){
        
        let movieTestId = 420818
        let networkRouter = MovieDetailRouter.getImages(movieId: movieTestId)
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: networkRouter)
        let imagesResults = DataBaseManager.shared.queryCoreData(MovieImagesModel.self, search: queryRouter.queryPredicate)
       
        //Solo debe existir un registro en coredata
        XCTAssert(imagesResults.count == 1)
        
        // Se comprueba que efectivamente es la misma pelicula y la data se almaceno y recupero correctamente
        XCTAssert(imagesResults.first?.id == movieTestId)
    }
    
    func testMovieDetailQueryRouter_getMovieVideos(){
       
        let movieTestId = 420818
        let networkRouter = MovieDetailRouter.getVideos(movieId: movieTestId)
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: networkRouter)
        let videoResults = DataBaseManager.shared.queryCoreData(MovieVideoModel.self, search: queryRouter.queryPredicate)
        
        //Solo debe existir un registro en coredata
        XCTAssert(videoResults.count == 1)
        
        // Se comprueba que efectivamente es la misma pelicula y la data se almaceno y recupero correctamente
        XCTAssert(videoResults.first?.id == movieTestId)
    }
    
    //MOVIELISTROUTER
    func testMovieListQueryRouter_getTopRated(){
        
        let pageToQuery = 1
        let categoryId = "Top Rated"
        let netRouter = HomeRouter.topRated(page: pageToQuery)
        let queryRouter = MovieListQueryRouter.init(networkRouter: netRouter, categoryId: categoryId)
        let movieResult = DataBaseManager.shared.queryCoreData(MovieListModel.self, search: queryRouter.queryPredicate)
       
        //SOLO DEBE EXISTIR UN REGISTRO
        XCTAssert(movieResult.count == 1)
        
        //LA CATEGORIA DEBE TENER RESULTADOS
        XCTAssert(movieResult.first?.results.count ?? 0 > 0)
    
    }
    
    func testMovieListQueryRouter_getPopular(){
        let pageToQuery = 1
        let categoryId = "Popular"
        let netRouter = HomeRouter.popular(page: pageToQuery)
        let queryRouter = MovieListQueryRouter.init(networkRouter: netRouter, categoryId: categoryId)
        let movieResult = DataBaseManager.shared.queryCoreData(MovieListModel.self, search: queryRouter.queryPredicate)
        
        //SOLO DEBE EXISTIR UN REGISTRO
        XCTAssert(movieResult.count == 1)
        
        //LA CATEGORIA DEBE TENER RESULTADOS
        XCTAssert(movieResult.first?.results.count ?? 0 > 0)
    }
    
    func testMovieListQueryRouter_getUpcoming(){
        let pageToQuery = 1
        let categoryId = "Upcoming"
        let netRouter = HomeRouter.upcoming(page: pageToQuery)
        let queryRouter = MovieListQueryRouter.init(networkRouter: netRouter, categoryId: categoryId)
        let movieResult = DataBaseManager.shared.queryCoreData(MovieListModel.self, search: queryRouter.queryPredicate)
        //SOLO DEBE EXISTIR UN REGISTRO
        XCTAssert(movieResult.count == 1)
        
        //LA CATEGORIA DEBE TENER RESULTADOS
        XCTAssert(movieResult.first?.results.count ?? 0 > 0)
    }
    
}
