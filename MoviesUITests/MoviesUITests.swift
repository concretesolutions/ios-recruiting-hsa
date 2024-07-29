//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Pedro on 23-07-24.
//

import XCTest

final class MoviesUITests: XCTestCase {
    func testActiveBuildConfiguration() {
        XCTAssertEqual(ActiveBuildInfo.name, "UI_TEST")
    }
}
