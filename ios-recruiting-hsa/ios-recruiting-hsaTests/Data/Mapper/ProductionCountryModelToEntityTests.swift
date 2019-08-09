//
//  ProductionCountryModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class ProductionCountryModelToEntityTests: XCTestCase {
    var productionCountryModelToEntity: Mapper<ProductionCountryModel, ProductionCountryEntity>!
    
    override func setUp() {
        super.setUp()
        productionCountryModelToEntity = ProductionCountryModelToEntity()
    }
    
    override func tearDown() {
        productionCountryModelToEntity = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let entity = try? ProductionCountryEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = productionCountryModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.iso31661, model.iso31661)
        XCTAssertEqual(entity.name, model.name)
    }
}
