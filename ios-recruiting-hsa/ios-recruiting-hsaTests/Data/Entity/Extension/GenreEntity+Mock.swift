//
//  GenreEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension GenreEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "GenreEntity") throws -> GenreEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(GenreEntity.self, from: json)
        return entity
    }
}
