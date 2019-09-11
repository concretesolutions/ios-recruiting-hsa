//
//  Movies.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

struct Movies: Codable {
    let id: Int
    let originalTitle: String
    let posterPath: String
    let overview: String
    let releaseDate: String
}

struct MoviePopularResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movies]
}

// Drawer Notification Type when using on ViewModel
enum CellRowType: String {
    case isText
    case isImage
    case isFavorite
}

struct MovieCellRows {
    let text: String
    let rowType: CellRowType
}

// GENRE REQUEST
struct MovieDetailResponse: Codable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genres: [GenreDictionary]
}

struct GenreListResponse: Codable {
    let genres: [GenreDictionary]
}

struct GenreDictionary: Codable {
    let id: Int
    let name: String
}

struct FilterRows: Codable {
    let title: String
    let value: String
}
