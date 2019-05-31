//
//  FavoriteMovieCellViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
protocol FavoriteMovieCellViewModel {
    var title: String { get }
    var year: String { get }
    var description: String { get }
    var posterURL: URL? { get }
}

class FavoriteMovieCellViewModelImpl {

    private let movie: PopularMovie

    init(movie: PopularMovie) {
        self.movie = movie
    }
}

extension FavoriteMovieCellViewModelImpl: FavoriteMovieCellViewModel {
    var title: String { return movie.title ?? "" }
    var year: String { return movie.releaseDate ?? "" }
    var description: String { return movie.overview ?? "" }
    var posterURL: URL? { return movie.posterURL }
}
