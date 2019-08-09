//
//  ErrorModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class ErrorModelToEntityTests: XCTestCase {
    var errorModelToEntity: Mapper<ErrorModel, ErrorEntity>!
    
    override func setUp() {
        super.setUp()
        errorModelToEntity = ErrorModelToEntity()
    }
    
    override func tearDown() {
        errorModelToEntity = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let entity = try? ErrorEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = errorModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.statusCode, model.statusCode)
        XCTAssertEqual(entity.statusMessage, model.statusMessage)
    }
}
