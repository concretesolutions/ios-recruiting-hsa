//
//  MovieResponseEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension MovieResponseEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "MovieResponseEntity") throws -> MovieResponseEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(MovieResponseEntity.self, from: json)
        return entity
    }
}
