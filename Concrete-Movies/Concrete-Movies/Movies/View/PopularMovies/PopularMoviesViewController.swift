//
//  PopularMoviesViewController.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var searchActive : Bool = false
    
    private var datasource: PopularMoviesDataSource?
    var moviesList: [SimpleMovieViewModel]?
    var filteredMoviesList: [SimpleMovieViewModel] = []
    
    private var popularMoviesPresenter: PopularMoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }
    
    convenience init(datasource: PopularMoviesDataSource,
                     presenter: PopularMoviesPresenter) {
        self.init()
        presenter.popularMoviesView = self
        self.popularMoviesPresenter = presenter
        datasource.viewController = self
        self.datasource = datasource
        
        //whatever
        let localMoviesDS = LocalDBMoviesDataSource(localMoviesDB: LocalMoviesRealmDB())
        localMoviesDS.favoritedMoviesEntity { (movies, error) in
            if let movies = movies{
                print(movies)
            }else{
                print("error fetcging local movies")
            }
        }
    }

    private func prepare(){
        prepareCoplllectionView()
        prepareSearchBar()
        
        popularMoviesPresenter?.fetchMovies()
        
        /*let restApi = MoviesAlamoFireRestApi()
        restApi.popularMoviesEntity { (movies, error) in
            if let movies = movies{
                print(movies)
            }else if let error = error{
                print(error)
            }
        }
        
        restApi.movieDetailEntity { (movie, error) in
            if let movie = movie{
                print(movie)
            }else if let error = error{
                print(error)
            }
        }*/
    }
    
    private func prepareCoplllectionView(){
        //moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = datasource
        
        moviesCollectionView.register(
            UINib(nibName: PopularMoviesConstants.moviesCellNibName, bundle: nil),
            forCellWithReuseIdentifier: PopularMoviesConstants.movieCellIdentifier
        )
    }
    
    private func prepareSearchBar(){
        moviesSearchBar.backgroundColor = Colors.Primary.accent
        moviesSearchBar.delegate = self
    }

}

extension PopularMoviesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        guard let moviesList = moviesList else {return}
        
        let filtered = moviesList.filter({ (movie) -> Bool in
            //let tmp: NSString = movie.title as NSString
            //let range = tmp.range(of: searchText, options: .caseInsensitive)
            //return range.location != NSNotFound
            return movie.title.contains(searchText)
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.filteredMoviesList = filtered
        self.moviesCollectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
}

extension PopularMoviesViewController: PopularMoviesViewProtocol{
    func show(error: Error) {
        print(error)
    }
    
    func show(movies: [SimpleMovieViewModel]) {
        print(movies)
        self.moviesList = movies
        moviesCollectionView.reloadData()
    }
}

extension PopularMoviesViewController: PopularMovieSelectionDelagate{
    func favoriteIconTapped(movieId: String) {
        print("tapped favorite \(movieId)")
    }
    
    func moviePosterTapped(movieId: String) {
        print("tapped poster \(movieId)")
        guard let viewController = ViewControllerFactory.viewController(type: .movieDetail) as? MovieDetailsViewController else {return}
        viewController.movieId = movieId
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
