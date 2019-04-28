//
//  MoviesRestApi.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

protocol MoviesRestApi {
    func popularMoviesEntity(completionHandler: @escaping (PopularMoviesResultEntity?, Error?)->Void)
}
