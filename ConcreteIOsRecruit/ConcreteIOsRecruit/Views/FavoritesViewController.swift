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
        debugPrint("viewDidLoad")
        super.viewDidLoad()
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.cellReuseId = .MovieRowCollectionViewCell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("viewWillAppear")
        super.viewWillAppear(animated)
        self.configureView()
    }
    
    func configureView(){
        debugPrint("configureView")
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        
        favoritesDataManager = FavoritesDataManger() //this triggers the fetch movies from local storage
        moviesCollectionView.movies = favoritesDataManager.favorites.movies
        addEmptyMessage()
    }
    
    func addEmptyMessage(){
        debugPrint("addEmptyMessage")
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
        debugPrint("didTap")
        self.selectedMovie = cell.movie
        self.performSegue(withIdentifier: Segues.goToMovieDtails.rawValue, sender: self)
    }
    
    func didTapFav(cell: MovieCollectionViewCell) {
        debugPrint("")
        //remove the item from favorites
        if let movie = cell.movie{
            _ = favoritesDataManager.addRemoveMovie(movie: movie)
            self.moviesCollectionView.movies = favoritesDataManager.favorites.movies
        }
    }
}

extension FavoritesViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let originalMovies = favoritesDataManager.favorites.movies
        if let searchString = searchController.searchBar.text, !searchString.isEmpty{
            
            let filteredMovies = originalMovies.filter({
                $0.title.lowercased().contains(searchString.lowercased()) ||
                $0.originalTitle.lowercased().contains(searchString.lowercased())
            })
            
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
            if originalMovies.count == 0{
                self.moviesCollectionView.addMessageView(type: .emptyFavorites)
            }
        }
    }
}
