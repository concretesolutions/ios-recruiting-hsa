//
//  FavoritesViewModel.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class FavoritesViewModel: NSObject {
    
    //MARK: Global Variables
    
    var movieRepository = MovieRepository()
    
    //MARK: Custom init
    
    func removeFavorite(id: Int) -> Bool{
        return self.movieRepository.removeFavorite(id: id)
    }
    func listFavorites() -> [MovieEntry?]{
        return self.movieRepository.listFavorites()
    }
}
