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
        guard let movieResponseEntity = try? MovieResponseEntity.mocked(testCase: self), let entity = movieResponseEntity.results.first else {
            XCTFail("Failed to create entity")
            return
        }
        let model = movieModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.voteCount, model.voteCount)
        XCTAssertEqual(entity.id, model.id)
        XCTAssertEqual(entity.isVideo, model.isVideo)
        XCTAssertEqual(entity.voteAverage, model.voteAverage)
        XCTAssertEqual(entity.title, model.title)
        XCTAssertEqual(entity.popularity, model.popularity)
        XCTAssertEqual(entity.posterPath, model.posterPath)
        XCTAssertEqual(entity.originalLanguage, model.originalLanguage)
        XCTAssertEqual(entity.originalTitle, model.originalTitle)
        XCTAssertEqual(entity.genreIds, model.genreIds)
        XCTAssertEqual(entity.backdropPath, model.backdropPath)
        XCTAssertEqual(entity.isAdult, model.isAdult)
        XCTAssertEqual(entity.overview, model.overview)
        XCTAssertEqual(entity.releaseDate, FormatHelper.stringDate(from: model.releaseDate!))
    }
}
