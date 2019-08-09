//
//  ProductionCompanyModelToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class ProductionCompanyModelToEntityTests: XCTestCase {
    var productionCompanyModelToEntity: Mapper<ProductionCompanyModel, ProductionCompanyEntity>!
    
    override func setUp() {
        super.setUp()
        productionCompanyModelToEntity = ProductionCompanyModelToEntity()
    }
    
    override func tearDown() {
        productionCompanyModelToEntity = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let entity = try? ProductionCompanyEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = productionCompanyModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.id, model.id)
        XCTAssertEqual(entity.logoPath, model.logoPath)
        XCTAssertEqual(entity.name, model.name)
        XCTAssertEqual(entity.originCountry, model.originCountry)
    }
}
