//
//  PartEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension PartEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "PartEntity") throws -> PartEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(PartEntity.self, from: json)
        return entity
    }
}
