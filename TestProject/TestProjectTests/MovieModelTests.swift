//
//  MovieModelTests.swift
//  TestProjectTests
//
//  Created by Felipe S Vergara on 22-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation
import XCTest
@testable import TestProject

class MovieModelTests: XCTestCase {
    
    
    //FileName : Is the the name of the file how is being saved in local data, so we must check it will not be changed in future
    func testFileName(){
        let movie = MovieModel()
        XCTAssertEqual(movie.fileName, "Favoritos")
    }
    
    //GetAllMovies
    func testGetAllMovies(){
        APIManager.shared.getMovies(completition: { (movies) in
            if let mov = movies{
                XCTAssertTrue(mov.count > 0)
            }else{
                XCTFail()
            }
        }) { (error) in
            XCTFail()
        }
    }
    
    //Validate filteredMovies (by title) when returns not empty
    func testGetFilteredMovies_returnsNotEmpty(){
        //Declare
        let movie = MovieModel()
        var moviesToFilter:[Movie] = []
        let venom = Movie(voteCount: 120, id: 123123, video: false, voteAverage: 5.6, title: "Venom", popularity: 4.5, posterPath: "", originalTitle: "Venom", genreIDS: [1,23], backdropPath: "", adult: false, overview: "", releaseDate: "")
        //Add movie
        moviesToFilter.append(venom)
        XCTAssert(moviesToFilter.count > 0)
        
        let searhTerm = "Venom"
        XCTAssertTrue(movie.getFilteredMovies(moviesToFilter: moviesToFilter, bySearchTerm: searhTerm).count > 0)
    }
    
    //Validate filteredMovies when returns empty
    func testGetFilteredMovies_returnsEmpty(){
        let movie = MovieModel()
        
        let moviesToFilter:[Movie] = []
        let searhTerm = "Venom"
        
        XCTAssertTrue(movie.getFilteredMovies(moviesToFilter: moviesToFilter, bySearchTerm: searhTerm).count == 0)
    }
    
    //Validate filteredMovies (by title)
    func testGetFilteredMovies_filter(){
        //Declare
        let movie = MovieModel()
        var moviesToFilter:[Movie] = []
        let venom = Movie(voteCount: 120, id: 123123, video: false, voteAverage: 5.6, title: "Venom", popularity: 4.5, posterPath: "", originalTitle: "Venom", genreIDS: [1,23], backdropPath: "", adult: false, overview: "", releaseDate: "")
        //Add movie
        moviesToFilter.append(venom)
        XCTAssert(moviesToFilter.count > 0)
        
        let searhTerm = "Venom"
        let filteredMovies = movie.getFilteredMovies(moviesToFilter: moviesToFilter, bySearchTerm: searhTerm)
        XCTAssert(filteredMovies.count > 0)
        
        for movies in filteredMovies{
            XCTAssertTrue(movies.title == "Venom")
        }
    }
    
    //Genre from API
    func testGetMovieGenresFromAPI(){
        APIManager.shared.getGenres(completition: { (genres) in
            if let g = genres{
                XCTAssertTrue(g.count > 0)
            }else{
                XCTFail()
            }
        }) { (error) in
            XCTFail()
        }
    }
    
    //Save favorites
    func testSaveMovieToFavorites(){
        //Declare
        let movie = MovieModel(isTest: true)
        let schindlerMovie = Movie(voteCount: 120, id: 123123, video: false, voteAverage: 5.6, title: "Schindler", popularity: 4.5, posterPath: "", originalTitle: "Schindler", genreIDS: [1,23], backdropPath: "", adult: false, overview: "", releaseDate: "")
        
        movie.saveMovieToFavorites(movie: schindlerMovie)
        
        //Load Favoreites to validate
        let tempMovie = Storage.fileExists("TestFavoritos", in: .documents) ? Storage.retrieve("TestFavoritos", from: .documents, as: [Movie].self) : []
        XCTAssert(tempMovie.count > 0)
        //We do a for for every movie in our local data.
        for movies in tempMovie{
            print(movies.title)
            if movies.title == "Schindler"{
                XCTAssertTrue(movies.title == "Schindler")
                return
            }
        }
        XCTFail()
    }
    
    //Remove favorites
    func testRemoveFavorites(){
        var movieCount = 0
        //Declare
        let movie = MovieModel(isTest: true)
        let schindlerMovie = Movie(voteCount: 120, id: 123123, video: false, voteAverage: 5.6, title: "Schindler", popularity: 4.5, posterPath: "", originalTitle: "Schindler", genreIDS: [1,23], backdropPath: "", adult: false, overview: "", releaseDate: "")
        movie.saveMovieToFavorites(movie: schindlerMovie)
        //Do we have movies saved?
        let tempMovie = Storage.fileExists("TestFavoritos", in: .documents) ? Storage.retrieve("TestFavoritos", from: .documents, as: [Movie].self) : []
        XCTAssert(tempMovie.count > 0)
        //If pass...
        movieCount = tempMovie.count
        //Remove it
        movie.removeMovieFromFavorite(movie: schindlerMovie)
        //Check again
        let tempMovieAfterRemoved = Storage.fileExists("TestFavoritos", in: .documents) ? Storage.retrieve("TestFavoritos", from: .documents, as: [Movie].self) : []
        //movieCount must be
        XCTAssertTrue(movieCount > tempMovieAfterRemoved.count)
        
    }
    
    //GetUrl
    func testGetUrlImage_resNotEmpty(){
        let schindlerMovie = Movie(voteCount: 120, id: 123123, video: false, voteAverage: 5.6, title: "Schindler", popularity: 4.5, posterPath: "www.google.cl", originalTitle: "Schindler", genreIDS: [1,23], backdropPath: "", adult: false, overview: "", releaseDate: "")
         XCTAssertTrue(schindlerMovie.getUrlImage().absoluteString.count > 0)
    }
    
}
