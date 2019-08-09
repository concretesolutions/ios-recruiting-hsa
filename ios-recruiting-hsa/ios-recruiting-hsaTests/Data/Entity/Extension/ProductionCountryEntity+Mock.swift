//
//  ProductionCountryEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension ProductionCountryEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "ProductionCountryEntity") throws -> ProductionCountryEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(ProductionCountryEntity.self, from: json)
        return entity
    }
}
