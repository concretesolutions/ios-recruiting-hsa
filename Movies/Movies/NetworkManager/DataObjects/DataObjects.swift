//
//  DataObjects.swift
//  Movies
//
//  Created by Consultor on 12/12/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import Foundation

struct GenericPagedMovieResponse: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let backdrop_path: String
    let overview: String
    let release_date: Date?
    var isFavorite: Bool? = false
    var genresString: String?
    
    enum MovieParameters: String, CodingKey {
        case id
        case title
        case poster_path
        case original_language
        case original_title
        case genre_ids
        case backdrop_path
        case overview
        case release_date
        case isFavorite
        case genresString
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MovieParameters.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        poster_path = try values.decode(String.self, forKey: .poster_path)
        original_language = try values.decode(String.self, forKey: .original_language)
        original_title = try values.decode(String.self, forKey: .original_title)
        genre_ids = try values.decode([Int].self, forKey: .genre_ids)
        backdrop_path = try values.decode(String.self, forKey: .backdrop_path)
        overview = try values.decode(String.self, forKey: .overview)
        let dateString = try values.decode(String.self, forKey: .release_date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        release_date = dateFormatter.date(from: dateString)
        genresString = ""
        isFavorite = false
        print("\(title): \(isFavorite ?? false)")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieParameters.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(original_language, forKey: .original_language)
        try container.encode(original_title, forKey: .original_title)
        try container.encode(genre_ids, forKey: .genre_ids)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(original_title, forKey: .original_title)
        try container.encode(genre_ids, forKey: .genre_ids)
        try container.encode(overview, forKey: .overview)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: release_date ?? Date())
        try container.encode(dateString, forKey: .release_date)
    }
    
    mutating func setGenreString(_ genreArray: [Genre]){
        var tempGenreString = ""
        for (index,genreId) in genre_ids.enumerated() {
            let genre = genreArray.first(where: {$0.id == genreId})
            if index != (genre_ids.endIndex - 1){
                tempGenreString += "\(genre?.name ?? ""), "
            } else {
                tempGenreString += "\(genre?.name ?? "")"
            }
        }
        genresString = tempGenreString
    }
    
    mutating func setFavorite(){
        isFavorite = !(isFavorite ?? false)
        if isFavorite ?? false {
            DefaultsManager().addFavorite(self)
        } else {
            DefaultsManager().removeFavorite(self)
        }
    }
}

struct GenresResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable{
    let id: Int
    let name: String
}

