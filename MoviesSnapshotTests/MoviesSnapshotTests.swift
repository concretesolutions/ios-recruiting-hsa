//
//  MoviesSnapshotTests.swift
//  MoviesSnapshotTests
//
//  Created by Pedro on 28-07-24.
//

import XCTest

final class MoviesSnapshotTests: XCTestCase {
    func testActiveBuildConfiguration() {
        XCTAssertEqual(ActiveBuildInfo.name, "SNAPSHOT_TEST")
    }
}
