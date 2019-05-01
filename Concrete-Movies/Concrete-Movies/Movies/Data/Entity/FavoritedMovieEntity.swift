//
//  FavoritedMovieEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/29/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation
import RealmSwift

class FavoritedMovieEntity: Object{
    @objc dynamic var name = ""
    @objc dynamic var movieId = 0
    @objc dynamic var overview = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""
}
