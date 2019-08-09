//
//  CollectionEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension CollectionEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "CollectionEntity") throws -> CollectionEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(CollectionEntity.self, from: json)
        return entity
    }
}
