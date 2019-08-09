//
//  SpokenLanguageModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class SpokenLanguageModelToEntityTests: XCTestCase {
    var spokenLanguageModelToEntity: Mapper<SpokenLanguageModel, SpokenLanguageEntity>!
    
    override func setUp() {
        super.setUp()
        spokenLanguageModelToEntity = SpokenLanguageModelToEntity()
    }
    
    override func tearDown() {
        spokenLanguageModelToEntity = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let entity = try? SpokenLanguageEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = spokenLanguageModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.iso6391, model.iso6391)
        XCTAssertEqual(entity.name, model.name)
    }
}
