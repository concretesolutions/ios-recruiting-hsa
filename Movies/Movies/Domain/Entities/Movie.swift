//
//  Movie.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

class Movie: Identifiable, Codable {

    typealias Identifier = String

    let id: Identifier
    let title: String?
    let genreIDS: [Int]
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
    var isFavorite: Bool = false
    var imgURL: URL? {
        if let path = posterPath {
            return URL(string: "\(AppConfiguration().imagesBaseURL)/t/p/w300\(path)")
        }
        return nil
    }
    
    init(id: Movie.Identifier, title: String?, genreIDS: [Int], posterPath: String?, overview: String?, releaseDate: Date?, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.genreIDS = genreIDS
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
}
