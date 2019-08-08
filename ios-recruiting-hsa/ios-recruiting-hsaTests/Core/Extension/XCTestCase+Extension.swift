//
//  XCTestCase+Extension.swift
//  ios-recruiting-hsaTests
//
//  Created on 8/8/19.
//

import XCTest

extension XCTestCase {
    func readJSONData(fileName: String) -> Data {
        let testBundle = Bundle(for: type(of: self))
        if let fileURL = testBundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                return data
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("File: \(fileName), not found un Bundle")
        }
    }
}
