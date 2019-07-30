//
//  MoviesVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/25/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MoviesVC: UIViewController {
    
    
    
    //MARK: -  UIVars
    
    //Creating CollectionView
    
    let  collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        return collectionView
    }()
    
    lazy var refreshControl : UIRefreshControl = {
        let refresh = UIRefreshControl()
        collectionView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(self.refreshMovies), for: .valueChanged)
        return refresh
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.hidesWhenStopped = true
        return activity
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //MARK: Vars
    
    var paginating: Bool = false
    var currentPage: Int = 1
    var movies : [MovieModel] = []
    var favoritesMovies:[MovieModel] = []
    var filteredMovies = [MovieModel]()
    let reuseIdentifier = "MovieCell"
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.setupView()
        self.setupViewCell()
        self.setupSearchBar()
        self.getMovies()
        self.getFavoritesMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavoritesMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        activityIndicator.center = view.center
    }
    
    //MARK: Setups
    
    private func setupView(){
        
        //Confg CollectionView
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.backgroundColor = UIColor.white
        
        //Confg Navigation
        navigationItem.title = "Popular movies"
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        
        // set event to refresh controll //
//        refreshControl.addTarget(self,
//                                 action: #selector(self.getMovies(page: 1)),
//                                 for: .valueChanged)
    }
    
    private func setupViewCell() {
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setupSearchBar(){
        
        // set search bar //
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = // Set text color
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = .white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
                
            }
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesBottomBarWhenPushed = true
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    //MARK: Funcs
    
   @objc private func getMovies(page: Int = 1){
        
        self.currentPage = page
    
        if !refreshControl.isRefreshing{
            activityIndicator.startAnimating()
        }
        
        GlobalServices.shared.movieServices.getMovies(page: page) { (response) in
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
            
            self.paginating = false
            
            switch response {
                
            case .success(data: let movies):
                
                self.movies += movies.results
                
                DispatchQueue.main.async {
                    self.collectionView.backgroundView = nil
                    self.collectionView.reloadData()
                }
                
            case .error(error: let error):
                
                if self.movies.isEmpty{
                    
                    DispatchQueue.main.async {
                        let errorView = ErrorViewVC.create()
                        errorView.errorMessage.text = error.localizedDescription
                        errorView.errorImage.image = UIImage(named: "close")
                        self.collectionView.backgroundView = errorView
                        self.collectionView.backgroundView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
                    }
                }
                
                print(error.localizedDescription)
                
            }
            
        }
    }
    
    @objc func refreshMovies(){
        self.getMovies(page: 1)
    }
    
    private func getFavoritesMovies(){
        
        self.favoritesMovies = LocalStorage.getFavoritesMovies()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func filterMovies(for searchText: String) {
        filteredMovies = movies.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

//MARK: Implement CollectionView

extension MoviesVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCellVC
        
        var movie = movies[indexPath.item]
        
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMovies[indexPath.item]
        } else {
            movie = movies[indexPath.item]
        }
        
        cell.movieTitle.text = movie.title
        cell.moviePoster.sd_setImage(with: movie.getImageFullSize())
        
        let isFavorite = self.favoritesMovies.contains { (m) -> Bool in
            return m.id == movie.id
            
        }
        
        cell.favoriteButton.tintColor = isFavorite ? .red : .black
        
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        
        let size = (collectionView.bounds.width/2) - 20
        return CGSize(width: size,height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.item]
        let moviesDetailVC = MoviesDetailVC(movie: movie)
        self.navigationController?.pushViewController(moviesDetailVC, animated: true)
    }
    
}

//MARK: - Implement Feed Pagination
extension MoviesVC: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !paginating && distance < 5 {
            paginating = true
            self.getMovies(page: currentPage + 1)
            
        }
    }
}


//MARK: Implement Search Results Updating
extension MoviesVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterMovies(for: searchController.searchBar.text ?? "")
    }
    
}


//MARK: Implement Movie Cell delegate
extension MoviesVC: MovieCellDelegate{
    
    func favoriteButtonTapped(in cell: MovieCellVC) {
        
        if let indexPath = collectionView.indexPath(for: cell){
            
            var movie = movies[indexPath.item]
            
            if searchController.isActive && searchController.searchBar.text != "" {
                movie = filteredMovies[indexPath.item]
            } else {
                movie = movies[indexPath.item]
            }
            
            // if movie is favorite
            if self.favoritesMovies.contains(where: { (m) -> Bool in
                return m.id == movie.id
            }){
                // delete of favorite
                LocalStorage.favoriteMovie(delete: movie)
                self.favoritesMovies = LocalStorage.getFavoritesMovies()
                
            }else{
                // add to favorite
                self.favoritesMovies.insert(movie, at: 0)
                LocalStorage.favoriteMovie(save: movie)
            }
            
            collectionView.reloadItems(at: [indexPath])
            
        }
    }
}
