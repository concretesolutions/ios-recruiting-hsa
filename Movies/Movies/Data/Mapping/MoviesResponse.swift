//
//  MoviesResponse.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let results: [MovieDTO]
}

extension MoviesResponse {

    // MARK: - MovieDTO
    struct MovieDTO: Codable {
        let adult: Bool
        let backdropPath: String
        let genreIDS: [Int]
        let id: Int
        let originalLanguage, originalTitle, overview: String
        let popularity: Double
        let posterPath, releaseDate, title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

// MARK: - Mappings to Domain

extension MoviesResponse {
    func toDomain() -> [Movie] {
        return results.map { $0.toDomain() }
    }
}

extension MoviesResponse.MovieDTO {
    func toDomain() -> Movie {
        return .init(id: Movie.Identifier(id),
                     title: title,
                     genreIDS: genreIDS,
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: dateFormatter.date(from: releaseDate ))
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    return formatter
}()
