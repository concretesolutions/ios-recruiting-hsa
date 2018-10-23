//
//  ViewController.swift
//  TestProject
//
//  Created by Felipe S Vergara on 20-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieViewController: UIViewController {
    
    //Placeholder empty data set
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Declared movies
    var movie: [Movie] = []
    var filteredMovies: [Movie] = []
    var favoritesMovies: [Movie] = []
    //Detect when you are using searchBar's filter.
    var isFiltered = false
    //Selected Movie
    var selectedMovie: Movie?
    //Presenter defined.
    var presenter: MoviePresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup View
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Everytime we enter the view we must load favorites.
        self.presenter?.loadFavorites()
    }
    
    func setupView(){
        //CollectionView BackGroundColor
        self.collectionView.backgroundColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        self.placeHolderView.backgroundColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        //Nav and TabBar setUp - extensions
        self.navigationController?.setUpForApplication()
        self.tabBarController?.setUpForApplication()
        //SearchBar
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        
        //pass delegate to presenter
        self.presenter = MoviePresenter(delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let containerDetailViewController = segue.destination as? ContainerViewController{
            containerDetailViewController.movie = self.selectedMovie
            containerDetailViewController.delegate = self
        }
    }
}

//MARK: - Functionality
extension MovieViewController{
    //Check Filter Movies
    func checkEmptyData(){
        self.placeHolderView.isHidden = self.isFiltered && self.filteredMovies.count == 0 ? false : true
    }
}

//MARK: - CollectionView delegates
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Check counts to show placeholderViewEmptyDataSet
        checkEmptyData()
        return isFiltered ? self.filteredMovies.count : self.movie.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = isFiltered ? self.filteredMovies[indexPath.row] : self.movie[indexPath.row]
        cell.favoriteList = self.favoritesMovies
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let movieHeightSize = 300
        return CGSize(width: collectionView.bounds.size.width/2, height: CGFloat(movieHeightSize))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = self.movie[indexPath.row]
        self.performSegue(withIdentifier: "showMovieDetails", sender: self)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}

//MARK: - SearchBar delegates
extension MovieViewController: UISearchBarDelegate, UITextFieldDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0{
            self.presenter?.setFilter(isFiltering: false)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0{
            self.presenter?.setFilter(isFiltering: false)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.setFilter(isFiltering: false)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0{
            self.presenter?.setFilter(isFiltering: false)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchTextInMovies(searchText: searchText, movies: self.movie)
    }
}

//MARK: - CollectionView delegates
extension MovieViewController: MovieCellDelegate{
    func addFavEvent(movie: Movie) {
        self.presenter?.addFavorite(movie: movie)
    }
    
    func removeFavEvent(movie: Movie) {
        self.presenter?.removeFavorite(movie: movie)
    }
}

//MARK: - Response from PRESENTER to VIEW
extension MovieViewController: MovieEventResponse{
    func showLoading(show: Bool) {
        show ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
    func favoriteRemoved() {
        self.presenter?.loadFavorites()
    }
    
    func favoritesSaved() {
        self.presenter?.loadFavorites()
    }
    
    func favoritesLoaded(favorites: [Movie]) {
        self.favoritesMovies = favorites
        self.collectionView.reloadData()
    }
    
    func isFiltering(filtering: Bool) {
        isFiltered = filtering
        self.collectionView.reloadData()
        
    }
    
    func moviesFiltered(filteredMovies: [Movie]) {
        self.filteredMovies = filteredMovies
    }
    
    func moviesLoaded(movieList: [Movie]) {
        self.movie = movieList
        self.collectionView.reloadData()
    }
    
}

//MARK: - Nav-Tab SetUp
extension UINavigationController{
    func setUpForApplication(){
        //large title
        self.navigationBar.prefersLargeTitles = true
        //bar color
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        //text color
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}

extension UITabBarController{
    func setUpForApplication(){
        //bar color
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        //icons color
        self.tabBar.tintColor = .white
    }
}

