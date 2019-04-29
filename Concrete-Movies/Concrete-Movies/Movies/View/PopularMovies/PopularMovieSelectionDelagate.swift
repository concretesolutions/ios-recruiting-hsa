//
//  PopularMovieSelectionDelagate.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/29/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

protocol PopularMovieSelectionDelagate: class {
    func favoriteIconTapped(movieId: String)
    func moviePosterTapped(movieId: String)
}
