//
//  CollectionModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class CollectionModelToEntityTests: XCTestCase {
    var collectionModelToEntity: Mapper<CollectionModel, CollectionEntity>!
    
    override func setUp() {
        super.setUp()
        collectionModelToEntity = CollectionModelToEntity(partModelToEntity: PartModelToEntity())
    }
    
    override func tearDown() {
        collectionModelToEntity = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let entity = try? CollectionEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = collectionModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.overview, model.overview)
        XCTAssertEqual(entity.backdropPath, model.backdropPath)
        XCTAssertEqual(entity.posterPath, model.posterPath)
        XCTAssertEqual(entity.id, model.id)
        
        if let parts = entity.parts, let modelParts = model.parts {
            for index in (0...parts.count - 1) {
                XCTAssertEqual(parts[index].isAdult, modelParts[index].isAdult)
                XCTAssertEqual(parts[index].backdropPath, modelParts[index].backdropPath)
                XCTAssertEqual(parts[index].genreIds, modelParts[index].genreIds)
                XCTAssertEqual(parts[index].id, modelParts[index].id)
                XCTAssertEqual(parts[index].originalLanguage, modelParts[index].originalLanguage)
                XCTAssertEqual(parts[index].originalTitle, modelParts[index].originalTitle)
                XCTAssertEqual(parts[index].overview, modelParts[index].overview)
                XCTAssertEqual(parts[index].releaseDate, FormatHelper.stringDate(from: modelParts[index].releaseDate!))
                XCTAssertEqual(parts[index].posterPath, modelParts[index].posterPath)
                XCTAssertEqual(parts[index].popularity, modelParts[index].popularity)
                XCTAssertEqual(parts[index].title, modelParts[index].title)
                XCTAssertEqual(parts[index].isVideo, modelParts[index].isVideo)
                XCTAssertEqual(parts[index].voteAverage, modelParts[index].voteAverage)
                XCTAssertEqual(parts[index].voteCount, modelParts[index].voteCount)
            }
        }
    }
}
