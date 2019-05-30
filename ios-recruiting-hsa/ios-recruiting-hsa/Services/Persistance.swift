//
//  Persistance.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/29/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

enum PersistenceError: Error {
    case unableToRead(Error)
    case unableToWrite(Error)
    case unableToEncode(Error)
    case unableToDecode(Error)
    case unableToCreataDatDirectory(Error)
}

protocol Persistance {
    func save<T: Encodable>(data: T, forKey: String) throws
    func retreive<T: Decodable>(key: String) throws -> T?
}

func persistanceDefault() -> Persistance {

    let dataDirectory: URL
    do {
        let manager = FileManager.default
        let baseURL = try manager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        dataDirectory = baseURL.appendingPathComponent("Data")
        try manager.createDirectory(
            at: dataDirectory,
            withIntermediateDirectories: true,
            attributes: nil
        )
    } catch {
        fatalError("Data directory could not be created")
    }
    return PersistanceImpl(baseURL: dataDirectory)
}

// Implementation

class PersistanceImpl {

    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

extension PersistanceImpl: Persistance {

    private func getURL(for key: String) -> URL {
        return baseURL.appendingPathComponent(key)
    }

    func save<T: Encodable>(data: T, forKey key: String) throws {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        do {
            try archiver.encodeEncodable(data, forKey: key)
        } catch {
            throw PersistenceError.unableToEncode(error)
        }
        let fileURL = getURL(for: key)
        do {
            return try archiver.encodedData.write(to: fileURL)
        } catch {
            throw PersistenceError.unableToWrite(error)
        }
    }

    func retreive<T: Decodable>(key: String) throws -> T? {
        let fileURL = getURL(for: key)
        let data = try Data(contentsOf: fileURL)
        let unarchiver: NSKeyedUnarchiver
        do {
            unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
        } catch {
            throw PersistenceError.unableToRead(error)
        }
        return unarchiver.decodeDecodable(T.self, forKey: key)
    }

}
