//
//  PartModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class PartModelToEntityTests: XCTestCase {
    var partModelToEntity: Mapper<PartModel, PartEntity>!
    
    override func setUp() {
        super.setUp()
        partModelToEntity = PartModelToEntity()
    }
    
    override func tearDown() {
        partModelToEntity = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let entity = try? PartEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = partModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.isAdult, model.isAdult)
        XCTAssertEqual(entity.backdropPath, model.backdropPath)
        XCTAssertEqual(entity.genreIds, model.genreIds)
        XCTAssertEqual(entity.id, model.id)
        XCTAssertEqual(entity.originalLanguage, model.originalLanguage)
        XCTAssertEqual(entity.originalTitle, model.originalTitle)
        XCTAssertEqual(entity.overview, model.overview)
        XCTAssertEqual(entity.releaseDate, FormatHelper.stringDate(from: model.releaseDate!))
        XCTAssertEqual(entity.posterPath, model.posterPath)
        XCTAssertEqual(entity.popularity, model.popularity)
        XCTAssertEqual(entity.title, model.title)
        XCTAssertEqual(entity.isVideo, model.isVideo)
        XCTAssertEqual(entity.voteAverage, model.voteAverage)
        XCTAssertEqual(entity.voteCount, model.voteCount)
    }
}
