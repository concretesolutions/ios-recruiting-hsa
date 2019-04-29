//
//  PopularMoviesViewProtocol.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

protocol PopularMoviesViewProtocol{
    func show(movies: [SimpleMovieViewModel])
    func show(error: Error)
}
