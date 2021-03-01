//
//  Movie.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import Foundation

// MARK: - MovieResponse
class MovieResponse: Codable {
    let results: [Movie]?

    init(results: [Movie]?) {
        self.results = results
    }
}

// MARK: - Result
class Movie: Codable {
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    var title: String?
    var isFavorited: Bool = false
    var genresString: String?

    var bannerURL: URL? {
        if let path = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w300\(path)")
        }
        return nil
    }

    var year: String? {
        if let releaseDate = releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            let date = dateFormatter.date(from: releaseDate)
            dateFormatter.dateFormat = "yyyy"
            return  dateFormatter.string(from: date!)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }

    init(genreIDS: [Int]?, id: Int?, originalTitle: String?, overview: String?, posterPath: String?, releaseDate: String?, title: String?) {
        self.genreIDS = genreIDS
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
    }
}
