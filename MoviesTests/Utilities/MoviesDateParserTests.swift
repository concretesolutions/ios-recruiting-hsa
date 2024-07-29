//
//  MoviesDateParserTests.swift
//  MoviesTests
//
//  Created by Pedro on 27-07-24.
//

import XCTest
@testable import Movies

/// I should be testing GetYearFromDateUseCase
/// but I don't have more time to add usecases and update dependencies.
final class MoviesDateParserTests: XCTestCase {

    func testParseYearSuccessfully() throws {
        // Arrange
        let stringDate = "2024-06-11"
        let expectedYear = "2024"

        // Act
        let parsedYear = MoviesDateParser.parseYearFrom(stringDate: stringDate)

        // Assert
        XCTAssertEqual(parsedYear, expectedYear)
    }

    func testParseDateReturnNil() throws {
        // Arrange
        let stringDate = "invalid date"

        // Act
        let parsedYear = MoviesDateParser.parseYearFrom(stringDate: stringDate)

        // Assert
        XCTAssertNil(parsedYear)
    }
}
