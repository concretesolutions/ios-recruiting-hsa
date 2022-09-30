//
//  RealmMovieItem.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 29-09-22.
//

import Foundation
import RealmSwift

class RealmMovieItem: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var posterImageURL: String
    @Persisted var backdropImageURL: String?
    @Persisted var name: String
    @Persisted var releaseDate: String?
    @Persisted var genres: String
    @Persisted var descriptionText: String?
    @Persisted var isFavorite: Bool = false
}
