//
//  SecondViewController.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/17/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {

    var favoritesDataManager = FavoritesDataManger()
    @IBOutlet weak var moviesCollectionView: MoviesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesCollectionView.delegate = self
        favoritesDataManager = FavoritesDataManger() //this triggers the fetch movies from local storage
        moviesCollectionView.movies = favoritesDataManager.favorites.movies
    }
}

extension FavoritesViewController: MoviesCollectionViewDelegate{
    func didTap(cell: MovieCollectionViewCell) {}
    
    func didTapFav(cell: MovieCollectionViewCell) {
        //remove the item from favorites
        if let movie = cell.movie{
            _ = favoritesDataManager.addRemoveMovie(movie: movie)
            self.moviesCollectionView.movies = favoritesDataManager.favorites.movies
        }
    }
}

extension FavoritesViewController {
    override func updateSearchResults(for searchController: UISearchController) {
        let originalMovies = favoritesDataManager.favorites.movies
        if let searchString = searchController.searchBar.text, !searchString.isEmpty{
            let filteredMovies = originalMovies.filter({$0.originalTitle.contains(searchString)})
            moviesCollectionView.movies = filteredMovies
        }
        else{
            moviesCollectionView.movies = originalMovies
        }
    }
}

