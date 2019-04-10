//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/4/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit
import JGProgressHUD
import UIScrollView_InfiniteScroll

protocol MoviesViewProtocol : class {
    func showMovies(movies: [MovieViewModel],append : Bool)
    func showErrorFetch()
    func showLoading()
    func hideLoading()
    func showTimeOut()
    
}

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModels : [MovieViewModel] = []
    var viewModelsFiltered : [MovieViewModel] = []
    var presenter : MoviePresenter!
    var interactor : MovieInteractor!
    var router : MovieRouter!
    var genresInteractor : GenreInteractorProtocol!
    let hudLoading = JGProgressHUD(style: .dark)
    let searchController = UISearchController(searchResultsController: nil)

    var searchBarHome : UISearchController! = nil
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0,left: 20.0,bottom: 50.0,right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MovieInteractor()
        self.genresInteractor = GenreInteractor()
        self.router = MovieRouter(presentingViewController: self)
        self.presenter = MoviePresenter(movieInteractor: interactor, movieRouter: router)
        self.presenter.attachView(view: self)
        
        self.collectionViewConfig()
        self.navigationBarStyle()
        self.addSearchViewController()
        
        self.showLoading()
        presenter.fetchMovies()
        
        collectionView.addInfiniteScroll { (collectionView) -> Void in
            collectionView.performBatchUpdates({ () -> Void in
                self.presenter.fetchMovies()
            }, completion: { (finished) -> Void in
                collectionView.finishInfiniteScroll()
            });
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels = presenter.matchMovieWithFavorite(viewModels: viewModels)
        collectionView.reloadData()
    }
    
    func navigationBarStyle(){
        self.title = "Popular Movies"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9686772227, green: 0.8077141047, blue: 0.3574544787, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func collectionViewConfig(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MOVIECOLLECTIONCELL")
    }
    
    func addSearchViewController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func showErrorViewBackground(imageName: String, errorText : String){
        let customViewError : ErrorView = ErrorView(frame: collectionView.bounds)
        customViewError.errorImageView.image = UIImage(named: imageName)
        customViewError.errorLabel.text = errorText
        collectionView.backgroundView = customViewError
    }
    
    func hideViewError(){
        self.collectionView.backgroundView = nil
    }
    
}

extension MoviesViewController : MoviesViewProtocol {
    func showTimeOut() {
        showErrorViewBackground(imageName:"timeout_collection" , errorText: "Ups! hemos tenido problemas de conexión")
        hideLoading()
    }
    
    func showErrorFetch() {
        showErrorViewBackground(imageName:"error_collection" , errorText: "Ups! hemos tenido problemas cargando las peliculas")
        hideLoading()
    }
    
    func showLoading() {
        hudLoading.textLabel.text = "Cargando..."
        hudLoading.show(in: collectionView)
    }
    
    func hideLoading() {
        hudLoading.dismiss(afterDelay: 0.0)
    }
    
    func showMovies(movies: [MovieViewModel],append: Bool) {
        hideLoading()
        if append{
            viewModels.append(contentsOf: movies)
        }else{
            viewModels = movies
        }
        collectionView.reloadData()
    }
}

extension MoviesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering() ? viewModelsFiltered.count : viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MOVIECOLLECTIONCELL", for: indexPath) as! MovieCollectionViewCell
        if isFiltering(){
            cell.viewModel = viewModelsFiltered[indexPath.row]
            cell.titleMovieLabel .text = viewModelsFiltered[indexPath.row].title
            cell.favoriteImage.image = viewModelsFiltered[indexPath.row].favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
            cell.downloadImage()
        }else{
            cell.viewModel = viewModels[indexPath.row]
            cell.titleMovieLabel .text = viewModels[indexPath.row].title
            cell.favoriteImage.image = viewModels[indexPath.row].favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
            
        }
        cell.downloadImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rowTotal = viewModels.count/2
        if indexPath.row == rowTotal-3 {
            presenter.fetchMovies()
        }
    }
}

extension MoviesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let viewmodelToShow = isFiltering() ? viewModelsFiltered[indexPath.row] : viewModels[indexPath.row]
        presenter.showMovieDetail(for: viewmodelToShow)
    }
}

extension MoviesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func isFiltering() -> Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
   
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModelsFiltered = viewModels.filter{ $0.title.lowercased().contains(searchText.lowercased())}
        collectionView.reloadData()
    }
}




