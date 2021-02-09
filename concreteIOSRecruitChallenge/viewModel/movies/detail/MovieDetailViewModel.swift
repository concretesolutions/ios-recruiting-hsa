//
//  MovieDetailViewModel.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MovieDetailViewModel: NSObject {
    
    //MARK: Global Variables
    
    var movieRepository = MovieRepository()
    
    //MARK: Favorites Management
    
    func addFavorite(movie: MovieEntry){
        self.movieRepository.addFavorite(movie: movie)
    }
    func removeFavorite(id: Int) -> Bool{
        return self.movieRepository.removeFavorite(id: id)
    }
    func isFavorite(id: Int) -> Bool{
        return self.movieRepository.isFavorite(id: id)
    }
}
