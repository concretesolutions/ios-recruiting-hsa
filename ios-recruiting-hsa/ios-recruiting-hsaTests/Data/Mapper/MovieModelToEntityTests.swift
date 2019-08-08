//
//  MovieModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//
@testable import ios_recruiting_hsa
import XCTest

class MovieModelToEntityTests: XCTestCase {
    var movieModelToEntity: Mapper<MovieModel, MovieEntity>!
    
    override func setUp() {
        super.setUp()
        movieModelToEntity = MovieModelToEntity()
    }
    
    override func tearDown() {
        movieModelToEntity = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let movieResponseEntity = try? MovieResponseEntity.mocked(testCase: self), let movieEntity = movieResponseEntity.results.first else {
            XCTFail("Failed to create entity")
            return
        }
        let movieModel = movieModelToEntity.reverseMap(value: movieEntity)
        
        XCTAssertEqual(movieEntity.voteCount, movieModel.voteCount)
        XCTAssertEqual(movieEntity.id, movieModel.id)
        XCTAssertEqual(movieEntity.isVideo, movieModel.isVideo)
        XCTAssertEqual(movieEntity.voteAverage, movieModel.voteAverage)
        XCTAssertEqual(movieEntity.title, movieModel.title)
        XCTAssertEqual(movieEntity.popularity, movieModel.popularity)
        XCTAssertEqual(movieEntity.posterPath, movieModel.posterPath)
        XCTAssertEqual(movieEntity.originalLanguage, movieModel.originalLanguage)
        XCTAssertEqual(movieEntity.originalTitle, movieModel.originalTitle)
        XCTAssertEqual(movieEntity.genreIds, movieModel.genreIds)
        XCTAssertEqual(movieEntity.backdropPath, movieModel.backdropPath)
        XCTAssertEqual(movieEntity.isAdult, movieModel.isAdult)
        XCTAssertEqual(movieEntity.overview, movieModel.overview)
        XCTAssertEqual(movieEntity.releaseDate, FormatHelper.stringDate(from: movieModel.releaseDate!))
    }
}
