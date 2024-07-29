//
//  GenreStub.swift
//  Movies
//
//  Created by Pedro on 28-07-24.
//

import Foundation

// TODO: Ensure the jsons dot not get copied to the Release build
#if DEBUG
// swiftlint:disable force_try
class GenreStub: TestBundle {
    class var jsonResponseUrl: URL {
        return bundle.url(
            forResource: "MockGenreResponse",
            withExtension: "json"
        )!
    }
    class var genres: [Genre] {
        let data = try! Data(contentsOf: jsonResponseUrl)
        return try! JSONDecoder().decode(GenreResponse.self, from: data).genres
    }
}
#endif
