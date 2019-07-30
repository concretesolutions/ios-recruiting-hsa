//
//  FavoriteMoviesVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/25/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class FavoriteMoviesVC: UIViewController {
    
    //MARK: UIVars
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Vars
    
    let reuseIdentifier = "FavoriteMovieCell"
    var favoritesMovies:[MovieModel] = []
    var filteredMovies : [MovieModel] = []
    var selectedGenreId:Int?
    var selectedYear:Int?
    var filterActive = false
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.setupView()
        self.setupViewCell()
        self.getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupFilterButton()
        self.getFavorites()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: Setups
    
    private func setupView() {
        
        view.addSubview(tableView)
        
        // Eliminar extra cells//
        tableView.tableFooterView = UIView()
        
        //Confg Navigation
        navigationItem.title = "Favorite Movies"
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        
  
    }
    
    private func setupFilterButton(){
        
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        let imageName = self.filterActive ? "filterFill" : "filter"
        filterButton.setImage(UIImage(named: imageName), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }
    
    private func setupViewCell() {
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: Funcs
    
    @objc func filterButtonTapped(){
        
        let filterVC = FilterVC.createController(selectedGenreId: selectedGenreId,selectedYear: selectedYear)
        filterVC.hidesBottomBarWhenPushed = true
        filterVC.delegate = self
        self.navigationController?.pushViewController(filterVC, animated: true)
        
        
    }
    
    private func getFavorites(){
        self.favoritesMovies = LocalStorage.getFavoritesMovies()
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        }
        
        if self.favoritesMovies.isEmpty{
            DispatchQueue.main.async {
                let errorView = ErrorViewVC.create()
                errorView.errorMessage.text = "No favorites yet"
                errorView.errorImage.image = UIImage(named: "search")
                self.tableView.backgroundView = errorView
                self.tableView.backgroundView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
            }
        }
    }
    
    
    private func filterMovies(  searchText: String? = nil,
                                selectedYear:Int? = nil,
                                selectedGenreId:Int? = nil) {
        
        filteredMovies = favoritesMovies.filter { movie in
            
            var containYear = true
            var containGenre = true
            
            if let selectedYear = selectedYear{
                containYear = movie.release_date?.contains("\(selectedYear)") ?? false
            }
            
            if let selectedGenreId = selectedGenreId{
                containGenre = movie.genre_ids.contains(selectedGenreId)
            }
            
            return containYear && containGenre
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: Implement TableView

extension FavoriteMoviesVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterActive {
            return filteredMovies.count
        }
        return favoritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier ) as! FavoriteMovieCellVC
        cell.delegate = self
        
        var movie = favoritesMovies[indexPath.row]
        
        if filterActive {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = favoritesMovies[indexPath.row]
        }
        
        cell.movieTitle.text = movie.title
        cell.moviePoster.sd_setImage(with: movie.getImageFullSize())
        cell.movieDate.text = movie.release_date
        cell.movieOverview.text = movie.overview
        
        let isFavorite = self.favoritesMovies.contains { (m) -> Bool in
            return m.id == movie.id
            
        }
        
        cell.favoriteButton.tintColor = isFavorite ? .red : .black
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = favoritesMovies[indexPath.row]
        let moviesDetailVC = MoviesDetailVC(movie: movie)
        self.navigationController?.pushViewController(moviesDetailVC, animated: true)
    }
    
}

//MARK: - Implement favoriteCell Delegate
extension FavoriteMoviesVC: FavoriteMovieCellDelegate{
    func favoriteButtonTapped(in cell: FavoriteMovieCellVC) {
        if let indexPath = tableView.indexPath(for: cell){
            
            var movie = favoritesMovies[indexPath.row]
            
            if filterActive {
                movie = filteredMovies[indexPath.row]
            } else {
                movie = favoritesMovies[indexPath.row]
            }
            
            LocalStorage.favoriteMovie(delete: movie)
            favoritesMovies = LocalStorage.getFavoritesMovies()
            
            if filterActive {
                filteredMovies.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

//MARK: - Implement filter delegate
extension FavoriteMoviesVC: FilterDelegate{
    
    func doneFilterButtonTapped(genreId: Int?, year: Int?) {
        self.selectedYear = year
        self.selectedGenreId = genreId
        self.filterActive = genreId != nil || year != nil
        self.filterMovies(selectedYear: selectedYear, selectedGenreId: selectedGenreId)
    }
}
