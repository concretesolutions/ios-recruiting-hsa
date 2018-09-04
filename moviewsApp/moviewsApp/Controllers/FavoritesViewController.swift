//
//  FavoritesViewController.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/29/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit
import Toast_Swift
import CoreData

protocol FavoritesViewControllerDelegate : class {
    func didSelectFilters(array : [String : String])
}

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var removeFiltersButton: UIButton!
    
    var moviesFiltered = Movie.favorites
    var filters : [String : String] = [:]
    @IBOutlet weak var heightBUtton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegates()
        self.applyFilters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
        self.setupHeightButton()
        self.title = "Favorites"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.title = ""
    }
    
    override func setupDelegates(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.delegate = self
        self.search.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FiltersViewController
        vc.delegate = self
        if self.filters.count > 0{
            vc.valuesFilter = self.filters.map({$0.value})
        }
    }

    func applyFilters(){
        Movie.loadFavoritesFromStore()
        self.moviesFiltered = Movie.favorites
        self.filters.forEach { (key , value) in
            if value != ""{
                if key == "date"{
                    self.moviesFiltered = self.moviesFiltered.filter({$0.releaseDate?.split(separator: "-")[0].description == value})
                }
                else if key == "genre"{
                    self.moviesFiltered = self.moviesFiltered.filter({verifyGenre(genre: value , movie: $0)})
                }
            }
        }
        
        guard let text = self.search.text else {
            return
        }
        if text.count > 2{
            var array = [Favorites]()
            for movie in self.moviesFiltered {
                if movie.title?.lowercased().range(of: text.lowercased()) != nil {
                    array.append(movie)
                }
            }
            self.moviesFiltered = array
            self.tableView.reloadSections(IndexSet(0...0), with: .fade)
            return
        }
        self.tableView.reloadData()
    }
    
    func verifyGenre(genre: String ,movie : Favorites)-> Bool{
        let movieGenres = Genre.genres.filter({movie.genreIds!.contains($0.id!)}).map({$0.name})
        return movieGenres.contains(genre)
    }
    
    func setupHeightButton(){
        self.heightBUtton.constant = self.filters.filter({ (key , value) -> Bool in
            return value != ""
            }).count > 0 ? 45 : 0
        
        UIView.animate(withDuration: 0.5) {
            self.removeFiltersButton.layoutIfNeeded()
        }
    }
    
    @IBAction func removeFilters(_ sender: UIButton) {
        self.filters = [:]
        self.setupHeightButton()
        self.moviesFiltered = Movie.favorites
        self.applyFilters()
        self.tableView.reloadSections(IndexSet(0...0), with: .fade)
    }
}

extension FavoritesViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return !((searchBar.text?.count == 0 || searchBar.text?.last == " ") && text == " ")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.applyFilters()
    }
}

extension FavoritesViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "UNFAVORITE") { (action, indexPath) in
            Movie.favorites.remove(at: indexPath.row)
            self.moviesFiltered.remove(at: indexPath.row)
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: nil)
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToMovieDetail(movie: Movie(favorite : self.moviesFiltered[indexPath.row]))
    }
}

extension FavoritesViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite-movie-cell", for: indexPath) as! FavofiteMovieTableViewCell
        
        cell.titleLabel.text = moviesFiltered[indexPath.row].title
        cell.overviewLabel.text = moviesFiltered[indexPath.row].overview
        cell.yearLabel.text = moviesFiltered[indexPath.row].releaseDate?.split(separator: "-")[0].description
        guard let posterPath = moviesFiltered[indexPath.row].posterPath else {
            return cell
        }
        cell.posterImage.loadPicture(of: "\(baseURLS.posters.rawValue)\(posterPath)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
}

extension FavoritesViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension FavoritesViewController : FavoritesViewControllerDelegate{
    func didSelectFilters(array : [String : String]){
        self.filters = array
        self.search.text = ""
        self.applyFilters()
    }
}

extension FavoritesViewController : UINavigationControllerDelegate{
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if Movie.favorites.count == 0{
            self.view.makeToast("you do not have selected favorites movies")
            return false
        }
        return true
    }
}
