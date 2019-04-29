//
//  MovieDetailsPresenter.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/29/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class MovieDetailsPresenter {
    var movieDetailsView: MovieDetailsViewProtocol?
    
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let movieDetailViewModelToModelMapper: Mapper<MovieDetailsViewModel, MovieDetails>
    
    init(fetchMovieDetailsUseCase: FetchMovieDetailsUseCase,movieDetailViewModelToModelMapper: Mapper<MovieDetailsViewModel, MovieDetails>
        )
    {
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.movieDetailViewModelToModelMapper = movieDetailViewModelToModelMapper
    }
    
    func fetchMovieDetails(movieId: String){
        fetchMovieDetailsUseCase.execute(movieId: movieId) { (movieDetails, error) in
            if let movieDetails = movieDetails{
                self.movieDetailsView?.show(movie: self.movieDetailViewModelToModelMapper.reverseMap(value: movieDetails))
            }else if let error = error{
                self.movieDetailsView?.show(error: error)
            }else{
                //TODO implement Generic Error to handle this
                //self.movieDetailsView?.show(error: GenericError())
            }
        }
    }
}
