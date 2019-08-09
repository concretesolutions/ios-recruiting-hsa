//
//  SpokenLanguageEntity+Mock.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

@testable import ios_recruiting_hsa
import XCTest

extension SpokenLanguageEntity {
    static func mocked(testCase: XCTestCase, fileName: String = "SpokenLanguageEntity") throws -> SpokenLanguageEntity {
        let json = testCase.readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(SpokenLanguageEntity.self, from: json)
        return entity
    }
}
