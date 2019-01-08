//
//  Movie+MovieDetailsViewController.Row.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

extension Movie {
    subscript(row: MovieDetailsViewController.Row) -> MovieDetailsViewController.Row {
        switch row {
        case .poster: return .poster(UIImage())
        case .titleFavorite: return .titleFavorite(originalTitle, isFavorite)
        case .year: return .year(releaseDate.year)
        case .genres: return .genres(genreIDS.description)
        case .overview: return .overview(overview)
        }
    }
}
