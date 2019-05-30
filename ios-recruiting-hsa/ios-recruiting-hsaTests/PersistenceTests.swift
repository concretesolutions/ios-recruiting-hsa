//
//  PersistenceTests.swift
//  ios-recruiting-hsaTests
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import XCTest
@testable import ios_recruiting_hsa

class PersistenceTests: XCTestCase {

    private let fileManager = FileManager.default
    private var baseURL: URL!
    private var store: Persistance!

    override func setUp() {
        let temporaryPath = NSTemporaryDirectory()
        let dataPath = URL(fileURLWithPath: temporaryPath).appendingPathComponent("Data")
        baseURL = try? fileManager.url(
            for: .itemReplacementDirectory,
            in: .userDomainMask,
            appropriateFor: dataPath,
            create: true
        )
        XCTAssertNotNil(baseURL)
        store = PersistanceImpl(baseURL: baseURL!)
    }

    override func tearDown() {
        XCTAssertNotNil(try? fileManager.removeItem(at: baseURL))
    }

    func testPersistanceSaveAndRetreive() {
        let genre = Genre(id: 1, name: "genre")
        XCTAssertNotNil(try? store.save(data: genre, forKey: "genre"))
        XCTAssertNotNil(try? store.retreive(key: "genre") as Genre?)
    }

}
