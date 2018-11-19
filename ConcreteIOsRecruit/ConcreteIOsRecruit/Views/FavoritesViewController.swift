//
//  SecondViewController.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/17/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit


class FavoritesViewController: BaseViewController {

    enum Segues: String{
        case goToMovieDtails
    }

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
        addEmptyMessage()
    }
    
    func addEmptyMessage(){
        if self.favoritesDataManager.favorites.movies.count == 0{
            self.moviesCollectionView.addMessageView(type: .emptyFavorites)
        }
        else{
            self.moviesCollectionView.removeMessageView()
        }
    }
}

extension FavoritesViewController: MoviesCollectionViewDelegate{
    func didTap(cell: MovieCollectionViewCell) {
        debugPrint("go")
        self.performSegue(withIdentifier: Segues.goToMovieDtails.rawValue, sender: self)
    }
    
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
            if filteredMovies.count == 0{
                self.moviesCollectionView.addMessageView(type: .noSearchResults)
            }
            else{
                moviesCollectionView.movies = filteredMovies
                self.moviesCollectionView.removeMessageView()
            }
            
        }
        else{
            self.moviesCollectionView.removeMessageView()
            moviesCollectionView.movies = originalMovies
        }
    }
}
