//
//  MovieDetailsViewProtocol.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/29/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

protocol MovieDetailsViewProtocol {
    func show(movie: MovieDetailsViewModel)
    func show(error: Error)
}
