//
//  S.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

// MARK: - Represent the JSON https://api.themoviedb.org/3/movie/popular?
struct Movies: Codable {
    let page: Int
    var results: [Movie]
}
// MARK: - List Model
struct Movie: Codable {
    let id: Int
    let title: String
    var posterPath: String
    let genreIds: [Int]
    let overview: String
    let releaseDate: Date
    var favorite: Bool?
    var genre: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview
        case releaseDate = "release_date"
    }

    func getYear() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "YYYY"
        return dateFormatterPrint.string(from: self.releaseDate)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        posterPath =  try values.decode(String.self, forKey: .posterPath)
        genreIds = try values.decode([Int].self, forKey: .genreIds)
        overview = try values.decode(String.self, forKey: .overview)
        releaseDate = try values.decode(Date.self, forKey: .releaseDate)
    }
}
