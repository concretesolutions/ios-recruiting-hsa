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
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        moviesSearchBar.text = ""
        moviesSearchBar.endEditing(true)
        super.viewWillDisappear(animated)
    }
    
    convenience init(datasource: PopularMoviesDataSource,
                     presenter: PopularMoviesPresenter) {
        self.init()
        presenter.popularMoviesView = self
        self.popularMoviesPresenter = presenter
        datasource.viewController = self
        self.datasource = datasource
        
    }

    private func prepare(){
        prepareCoplllectionView()
        prepareSearchBar()
        
        showActivityIndicator()
        popularMoviesPresenter?.fetchMovies()
    }
    
    private func prepareCoplllectionView(){
        //moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = datasource
        
        moviesCollectionView.register(
            UINib(nibName: PopularMoviesConstants.moviesCellNibName, bundle: nil),
            forCellWithReuseIdentifier: PopularMoviesConstants.movieCellIdentifier
        )
        moviesCollectionView.register(
            UINib(nibName: PopularMoviesConstants.emptyCellNibName, bundle: nil),
            forCellWithReuseIdentifier: PopularMoviesConstants.emptyCellIdentifier)
    }
    
    private func prepareSearchBar(){
        moviesSearchBar.backgroundColor = Colors.Primary.accent
        moviesSearchBar.barTintColor = Colors.Primary.brand
        moviesSearchBar.tintColor = Colors.Primary.brand
        moviesSearchBar.delegate = self
    }
    
    private func showActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
    }

}

extension PopularMoviesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            searchActive = false
            self.moviesCollectionView.reloadData()
            return
        }else{
            searchActive = true
        }
        
        guard let moviesList = moviesList else {return}
        
        let filtered = moviesList.filter({ (movie) -> Bool in
            return movie.title.contains(searchText)
        })
        self.filteredMoviesList = filtered
        self.moviesCollectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? false{
            searchActive = false
        }else{
            searchActive = true;
        }
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

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 2
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        return CGSize.init(width: dimensions, height: dimensions / 2)
    }
    
}

extension PopularMoviesViewController: PopularMoviesViewProtocol{
    func show(error: Error) {
        activityIndicator.removeFromSuperview()
    }
    
    func show(movies: [SimpleMovieViewModel]) {
        activityIndicator.removeFromSuperview()
        self.moviesList = movies
        moviesCollectionView.reloadData()
    }
}

extension PopularMoviesViewController: PopularMovieSelectionDelagate{
    func favoriteIconTapped(movieId: Int, at indexPath: IndexPath) {
        
        guard var moviesList = moviesList else {return}
        
        let selctdMovie = moviesList.first(where: { $0.movieId == movieId })
        if let selctdMovie = selctdMovie{
            let movieFavd = FavoritedMovieViewModel(
                name: selctdMovie.title,
                movieId: movieId,
                overview: selctdMovie.overview,
                posterPath: selctdMovie.posterPath,
                releaseYear: selctdMovie.releaseDate)
            popularMoviesPresenter?.saveFavorite(movie: movieFavd)
        }
        var favMov = moviesList[indexPath.row]
        favMov.isFavorited = true
        let index = indexPath.row
        moviesList.remove(at: index)
        moviesList.insert(favMov, at: index)
        self.moviesList = moviesList
        moviesCollectionView.reloadData()
    }
    
    func moviePosterTapped(movieId: String) {
        guard let viewController = ViewControllerFactory.viewController(type: .movieDetail) as? MovieDetailsViewController else {return}
        viewController.movieId = movieId
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
