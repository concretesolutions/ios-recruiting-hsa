//
//  MovieDetailPresente.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieDetailPresentationLogic {
    func presentMovie(_ movie: MovieDetailModel)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var view: MovieDetailDisplayLogic?
    
    init(view: MovieDetailDisplayLogic) {
        self.view = view
    }
    
    func presentMovie(_ movie: MovieDetailModel){
        let posterUrl = movie.getBackDropImageURL()
        let features = getFeaturesArray(from: movie)
        
        let viewModel = MovieDetailViewModel.init(movieImageURL: posterUrl, featureList: features)
        view?.displayMovie(viewModel)
    }
    
    private func getFeaturesArray(from movie: MovieDetailModel)->[String]{
        var movieFeatures: [String] = []
        movieFeatures.append(movie.title)
        movieFeatures.append(movie.releaseDate)
        let genres = movie.genreList.map{$0.name}.joined(separator: ", ")
        movieFeatures.append(genres)
        movieFeatures.append(movie.overview)
        
        return movieFeatures
    }
}
