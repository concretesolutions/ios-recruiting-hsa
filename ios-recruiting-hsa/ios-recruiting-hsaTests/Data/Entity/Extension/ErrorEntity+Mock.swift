//
//  ErrorEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension ErrorEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "ErrorEntity") throws -> ErrorEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(ErrorEntity.self, from: json)
        return entity
    }
}
