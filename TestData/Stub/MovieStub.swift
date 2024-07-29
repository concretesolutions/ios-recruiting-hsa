//
//  MovieStub.swift
//  Movies
//
//  Created by Pedro on 28-07-24.
//

// TODO: Ensure the jsons dot not get copied to the Release build
#if DEBUG
// swiftlint:disable force_try
import Foundation

protocol TestBundle: AnyObject { }
extension TestBundle {
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
}
class MovieStub: TestBundle {
    class var jsonResponseUrl: URL {
        return bundle.url(
            forResource: "MockMovieResponse",
            withExtension: "json"
        )!
    }
    class var jsonBadResponseUrl: URL {
        return bundle.url(
            forResource: "MockBadMovieResponse",
            withExtension: "json"
        )!
    }
    class var movies: [Movie] {
        let data = try! Data(contentsOf: jsonResponseUrl)
        return try! JSONDecoder().decode(MovieResponse.self, from: data).results
    }
}
#endif
