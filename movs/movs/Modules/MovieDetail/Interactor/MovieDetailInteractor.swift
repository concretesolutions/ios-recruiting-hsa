//
//  MovieDetailInteractor.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieDetailBusinessLogic {
    func fetchMovieData()
}

class MovieDetailInteractor: MovieDetailBusinessLogic{
    
    private let presenter: MovieDetailPresentationLogic
    private let loader: MovieDetailLoader
    private let movieId: Int
    
    init(movieId: Int, loader: MovieDetailLoader, presenter: MovieDetailPresentationLogic) {
        self.movieId = movieId
        self.presenter = presenter
        self.loader = loader
    }
    
    func fetchMovieData() {
        loader.fetchDetailData(movieId: movieId) { (result) in
            switch result{
            case .success(let movieDetail):
                self.presenter.presentMovie(movieDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
