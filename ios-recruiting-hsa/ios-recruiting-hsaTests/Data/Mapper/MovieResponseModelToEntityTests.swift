//
//  MovieResponseModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class MovieResponseModelToEntityTests: XCTestCase {
    var movieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity>!
    
    override func setUp() {
        super.setUp()
        movieResponseModelToEntity = MovieResponseModelToEntity(movieModelToEntity: MovieModelToEntity())
    }
    
    override func tearDown() {
        movieResponseModelToEntity = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let entity = try? MovieResponseEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = movieResponseModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.page, model.page)
        XCTAssertEqual(entity.totalResults, model.totalResults)
        XCTAssertEqual(entity.totalPages, model.totalPages)
        
        for index in (0...entity.results.count - 1) {
            XCTAssertEqual(entity.results[index].voteCount, model.results[index].voteCount)
            XCTAssertEqual(entity.results[index].id, model.results[index].id)
            XCTAssertEqual(entity.results[index].isVideo, model.results[index].isVideo)
            XCTAssertEqual(entity.results[index].voteAverage, model.results[index].voteAverage)
            XCTAssertEqual(entity.results[index].title, model.results[index].title)
            XCTAssertEqual(entity.results[index].popularity, model.results[index].popularity)
            XCTAssertEqual(entity.results[index].posterPath, model.results[index].posterPath)
            XCTAssertEqual(entity.results[index].originalLanguage, model.results[index].originalLanguage)
            XCTAssertEqual(entity.results[index].originalTitle, model.results[index].originalTitle)
            XCTAssertEqual(entity.results[index].genreIds, model.results[index].genreIds)
            XCTAssertEqual(entity.results[index].backdropPath, model.results[index].backdropPath)
            XCTAssertEqual(entity.results[index].isAdult, model.results[index].isAdult)
            XCTAssertEqual(entity.results[index].overview, model.results[index].overview)
            XCTAssertEqual(entity.results[index].releaseDate, FormatHelper.stringDate(from: model.results[index].releaseDate!))
        }
    }
}
