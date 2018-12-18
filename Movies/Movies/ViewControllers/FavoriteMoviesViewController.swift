//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Consultor on 12/15/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    var favoritesSearchController: UISearchController!
    
    var favoriteMoviesArray: [Movie] = []
    var genres: [Genre] = []
    var originalArray: [Movie] = []
    
    var isSearching = false
    
    let cellIdentifier = "MovieTableViewCell"
    
    let detailSegueIdentifier = "ShowFavoriteMovieDetail"
    let emptyErrorView = ErrorView(error: ErrorTypes.emptyFavoritesError)
    let emptySearchErrorView = ErrorView(error: ErrorTypes.emptyListError)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //favoriteMoviesArray = DefaultsManager().favoriteMovies
        // Do any additional setup after loading the view.
        emptyErrorView.delegate = self
        emptySearchErrorView.delegate = self
        favoriteMoviesTableView.tableFooterView = UIView()
        favoritesSearchController = UISearchController(searchResultsController: nil)
        favoritesSearchController.searchResultsUpdater = self
        favoritesSearchController.delegate = self
        favoritesSearchController.searchBar.delegate = self
        self.tabBarController?.definesPresentationContext = true
        favoritesSearchController.hidesNavigationBarDuringPresentation = false
        
        favoritesSearchController.dimsBackgroundDuringPresentation = false
        favoritesSearchController.definesPresentationContext = true
        favoritesSearchController.searchBar.tintColor = UIColor.darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.searchController = favoritesSearchController
        self.tabBarController?.navigationItem.title = "Favorites"
        if !isSearching{
            favoriteMoviesArray = DefaultsManager.shared.favoriteMovies
            if favoriteMoviesArray.count > 0 {
                for (index, _) in self.favoriteMoviesArray.enumerated(){
                    self.favoriteMoviesArray[index].setGenreString(self.genres)
                    self.favoriteMoviesArray[index].isFavorite = DefaultsManager.shared.isMovieFavorite(self.favoriteMoviesArray[index])
                }
                originalArray = favoriteMoviesArray
                favoriteMoviesTableView.reloadData()
                favoriteMoviesTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
                emptyErrorView.hideErrorView()
                self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
            } else {
                view.addSubview(emptyErrorView)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == detailSegueIdentifier{
            if let destination = segue.destination as? MovieDetailViewController {
                destination.movie = sender as? Movie
            }
        }
    }
    
    
}
extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteMovieTableViewCell {
            cell.viewModel = FavoriteMovieTableViewCell.FavoriteViewModel(favoriteMoviesArray[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: favoriteMoviesArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: NSLocalizedString("title.action.delete", comment: ""), handler: {(action, indexPath) in
            DefaultsManager.shared.removeFavorite(self.favoriteMoviesArray[indexPath.item])
            self.favoriteMoviesArray.remove(at: indexPath.item)
            tableView.reloadData()
            if self.favoriteMoviesArray.count <= 0 {
                self.view.addSubview(self.emptyErrorView)
            }
        })
        return [deleteAction]
    }
    
}
extension FavoriteMoviesViewController: ErrorViewDelegate{
    func buttonAction(_ erroView: ErrorView) {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
        }
        erroView.hideErrorView()
    }
}
extension FavoriteMoviesViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, searchString != "" {
            isSearching = true
            favoriteMoviesArray = originalArray.filter({
                (movie: Movie) -> Bool in
                let lowerCaseOriginalTitle = movie.original_title.lowercased()
                let lowerCaseTitle = movie.title.lowercased()
                let lowerCaseSearchString = searchString.lowercased()
                return lowerCaseOriginalTitle.contains(lowerCaseSearchString) || lowerCaseTitle.contains(lowerCaseSearchString)
            })
            if favoriteMoviesArray.count <= 0 {
                view.addSubview(emptySearchErrorView)
            } else {
                emptySearchErrorView.hideErrorView()
            }
        } else {
            isSearching = false
            favoriteMoviesArray = originalArray
            emptySearchErrorView.hideErrorView()
        }
        favoriteMoviesTableView.reloadData()
    }
}

