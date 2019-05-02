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
    var filteredMoviesList: [FavoritedMovieViewModel] = []
    
    private var datasource: FavoriteMoviesDataSource?
    var moviesList: [FavoritedMovieViewModel]?
    
    private var favoriteMoviesPresenter: FavoriteMoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteMoviesPresenter?.fetchFavoriteMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        favoritesSearchBat.text = ""
        favoritesSearchBat.endEditing(true)
        super.viewWillDisappear(animated)
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
        prepareTapGesture()
    }
    
    private func prepareTableView(){
        favoritesTableView.dataSource = datasource
        favoritesTableView.delegate = self
        
        favoritesTableView.register(UINib(nibName: FavoriteMoviesConstants.favMovieCellNibName, bundle: nil),
                                    forCellReuseIdentifier: FavoriteMoviesConstants.favMovieCellIdentifier)
        favoritesTableView.register(UINib(nibName: FavoriteMoviesConstants.emptyCellNibName, bundle: nil),
                                    forCellReuseIdentifier: FavoriteMoviesConstants.emptyCellIdentifier)
    }
    
    private func prepareSearchBar(){
        favoritesSearchBat.backgroundColor = Colors.Primary.accent
        favoritesSearchBat.barTintColor = Colors.Primary.brand
        favoritesSearchBat.tintColor = Colors.Primary.brand
        favoritesSearchBat.delegate = self
    }
    
    private func prepareTapGesture(){
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }

    @objc
    private func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            // delete item at indexPath
            guard let moviesList = self.moviesList else {return}
            
            self.favoriteMoviesPresenter?.deleteFavoriteMovie(with: moviesList[indexPath.row].movieId)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            self.favoriteMoviesPresenter?.fetchFavoriteMovies()
        }
        
        /*
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // share item at indexPath
            //print("I want to share: \(self.tableArray[indexPath.row])")
        }
        share.backgroundColor = UIColor.lightGray
         */
        
        return [delete]
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let moviesList = moviesList else {return 200}
        
        if(searchActive){
            return filteredMoviesList.isEmpty ? tableView.bounds.size.height : 90
        }else{
            return moviesList.isEmpty ? tableView.bounds.size.height : 90
        }
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesViewProtocol{
    func show(movies: [FavoritedMovieViewModel]) {
        //print("received from bd \(movies)")
        moviesList = movies
        favoritesTableView.reloadData()
    }
    
    func show(error: Error) {
        //display error dialog or view
    }
}

extension FavoriteMoviesViewController: FavoriteMovieSelectionDelagate{
    func movieCellTapped(movieId: String) {
        guard let viewController = ViewControllerFactory.viewController(type: .movieDetail) as? MovieDetailsViewController else {return}
        viewController.movieId = movieId
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FavoriteMoviesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            searchActive = false
            self.favoritesTableView.reloadData()
            return
        }else{
            searchActive = true
        }
        
        guard let moviesList = moviesList else {return}
        
        let filtered = moviesList.filter({ (movie) -> Bool in
            return movie.name.contains(searchText)
        })
        self.filteredMoviesList = filtered
        self.favoritesTableView.reloadData()
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
        dismissKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
}
