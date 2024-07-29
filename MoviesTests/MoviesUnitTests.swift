//
//  MoviesUnitTests.swift
//  MoviesTests
//
//  Created by Pedro on 28-07-24.
//

import Foundation
import XCTest

final class MoviesUnitTests: XCTestCase {
    func testActiveBuildConfiguration() {
        XCTAssertEqual(ActiveBuildInfo.name, "DEBUG")
    }
}
