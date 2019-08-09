//
//  MovieDetailEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension MovieDetailEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "MovieDetailEntity") throws -> MovieDetailEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(MovieDetailEntity.self, from: json)
        return entity
    }
}
