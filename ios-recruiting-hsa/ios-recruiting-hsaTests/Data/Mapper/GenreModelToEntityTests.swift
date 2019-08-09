//
//  GenreModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class GenreModelToEntityTests: XCTestCase {
    var genreModelToEntity: Mapper<GenreModel, GenreEntity>!
    
    override func setUp() {
        super.setUp()
        genreModelToEntity = GenreModelToEntity()
    }
    
    override func tearDown() {
        genreModelToEntity = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let entity = try? GenreEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = genreModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.id, model.id)
        XCTAssertEqual(model.name, model.name)
    }
}
