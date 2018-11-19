//
//  FirstViewController.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/17/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit

class PopularMoviesViewController: BaseViewController {

    var movies : [Movie] = [Movie]() {
        didSet{
            self.moviesCollectionView.movies = movies
        }
    }
    @IBOutlet weak var moviesCollectionView: MoviesCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchController.delegate = self
        self.moviesCollectionView.delegate = self
        self.getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.movies = { self.movies }()
    }
    
    func getMovies(){
        MoviesAPIManager().getPopularMovies { (movies, error) in
            if let error = error{
                debugPrint("There are no movies to display: \(error)")
                return
            }
            if let movies = movies{
                self.movies = movies
            }
        }
    }
}

extension PopularMoviesViewController: MoviesCollectionViewDelegate{
    func didTapFav(cell: MovieCollectionViewCell) {}
    
    func didTap(cell: MovieCollectionViewCell) {
        debugPrint("Go to the movie details: \(cell)")
    }
}

extension PopularMoviesViewController {
    override func updateSearchResults(for searchController: UISearchController) {
        let originalMovies = self.movies
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
