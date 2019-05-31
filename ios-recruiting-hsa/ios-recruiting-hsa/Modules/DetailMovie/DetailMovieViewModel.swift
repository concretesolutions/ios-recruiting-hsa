//
//  DetailMovieViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol DetailMovieViewModel {
    var title: String { get }
    var isFavorite: Bool { get }
    var titleMovie: String { get }
    var yearMovie: String { get }
    var genres: [String] { get }
    var posterURL: URL? { get }
    var descriptionMovie: String { get }
}

class DetailMovieViewModelImpl {

    let movie: PopularMovie

    init(movie: PopularMovie) {
        self.movie = movie
    }
}

extension DetailMovieViewModelImpl: DetailMovieViewModel {
    var title: String { return "Detail" }
    var isFavorite: Bool { return Bool.random() }
    var titleMovie: String { return movie.title ?? "" }
    var yearMovie: String { return movie.releaseDate ?? "" }
    var genres: [String] { return movie.genreIds?.map { "\($0)" } ?? [] }
    var posterURL: URL? { return movie.posterURL }
    var descriptionMovie: String { return movie.overview ?? "" }
}
