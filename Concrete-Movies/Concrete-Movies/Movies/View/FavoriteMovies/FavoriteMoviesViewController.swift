//
//  FavoriteMoviesViewController.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    @IBOutlet weak var favoritesSearchBat: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var searchActive : Bool = false
    
    private var datasource: FavoriteMoviesDataSource?
    var moviesList: [FavoritedMovieViewModel]?
    
    private var favoriteMoviesPresenter: FavoriteMoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        
        favoriteMoviesPresenter?.fetchFavoriteMovies()
    }
    
    convenience init(datasource: FavoriteMoviesDataSource,
                     presenter: FavoriteMoviesPresenter) {
        self.init()
        presenter.favoriteMoviesView = self
        self.favoriteMoviesPresenter = presenter
        datasource.viewController = self
        self.datasource = datasource
        
    }

    private func prepare(){
        prepareSearchBar()
        prepareTableView()
    }
    
    private func prepareTableView(){
        favoritesTableView.register(UINib(nibName: FavoriteMoviesConstants.favMovieCellNibName, bundle: nil),
                                    forCellReuseIdentifier: FavoriteMoviesConstants.favMovieCellIdentifier)
    }
    
    private func prepareSearchBar(){
        favoritesSearchBat.backgroundColor = Colors.Primary.accent
        favoritesSearchBat.delegate = self
    }

}

extension FavoriteMoviesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = ViewControllerFactory.viewController(type: .movieDetail) as? MovieDetailsViewController,
        let moviesList = moviesList else {return}
        viewController.movieId = String(moviesList[indexPath.row].movieId)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesViewProtocol{
    func show(movies: [FavoritedMovieViewModel]) {
        moviesList = movies
        favoritesTableView.reloadData()
    }
    
    func show(error: Error) {
        //display error dialog or view
    }
}

extension FavoriteMoviesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        /*filtered = data.filter({ (text) -> Bool in
         let tmp: NSString = text
         let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
         return range.location != NSNotFound
         })
         if(filtered.count == 0){
         searchActive = false;
         } else {
         searchActive = true;
         }
         self.tableView.reloadData()
         */
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
