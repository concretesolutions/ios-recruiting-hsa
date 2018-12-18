//
//  ViewController.swift
//  Movies
//
//  Created by Consultor on 12/12/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var moviesArray: [Movie] = []
    var originalArray: [Movie] = []
    var genres: [Genre] = []
    @IBOutlet weak var movieGridCollectionView: UICollectionView!{
        didSet{
            movieGridCollectionView.dataSource = self
            movieGridCollectionView.delegate = self
        }
    }
    
    var popularSearchController: UISearchController!
    
    var currentPage: Int = 1
    var maxPages: Int = 1
    var currentLastIndex: Int = 0
    var isLoadingNextPage = false
    var isSearching = false
    
    let cellIdentifier = "MovieGridCollectionViewCell"
    let footerIdentifier = "loadingFooter"
    let detailSegueIdentifier = "ShowMovieDetail"
    
    let locale = NSLocale.current.languageCode
    
    let loadingView = LoadingView()
    let emptySearchErrorView = ErrorView(error: ErrorTypes.emptyListError)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        loadGenresAndMovies()
        popularSearchController = UISearchController(searchResultsController: nil)
        popularSearchController.searchResultsUpdater = self
        popularSearchController.delegate = self
        popularSearchController.searchBar.delegate = self
        self.tabBarController?.definesPresentationContext = true
        popularSearchController.hidesNavigationBarDuringPresentation = false
        
        popularSearchController.dimsBackgroundDuringPresentation = false
        popularSearchController.definesPresentationContext = true
        popularSearchController.searchBar.tintColor = UIColor.darkGray
        
    }
    
    func loadGenresAndMovies(){
        let network = NetworkAPIManager()
        
        let paramsGenres = ["api_key":network.apiKey,"language":locale ?? "es-US"] as [String : Any]
        view.addSubview(loadingView)
        network.request(urlString: "genre/movie/list", params: paramsGenres){
            (response: GenresResponse?, error: ErrorTypes?) in
            if let genresError = error {
                self.loadingView.hideAnimationView()
                let errorView = ErrorView(error: genresError)
                errorView.delegate = self
                self.movieGridCollectionView.addSubview(errorView)
            }else{
                if let array = response?.genres {
                    self.genres = array
                    if let favorites = self.tabBarController?.viewControllers?[1] as? FavoriteMoviesViewController{
                        favorites.genres = array
                    }
                    let params = ["api_key":network.apiKey,"page":self.currentPage,"language":self.locale ?? "en-US"] as [String : Any]
                    
                    network.request(urlString: "movie/popular", params: params){
                        (response: GenericPagedMovieResponse?, error: ErrorTypes?) in
                        self.loadingView.hideAnimationView()
                        if let movieError = error {
                            let errorView = ErrorView(error: movieError)
                            errorView.delegate = self
                            self.movieGridCollectionView.addSubview(errorView)
                        } else {
                            if let array = response?.results {
                                self.moviesArray = array
                                self.originalArray = self.moviesArray
                                self.maxPages = response?.total_pages ?? 1
                                self.setUpInitialMovies()
                            }
                        }
                    }
                }
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.searchController = popularSearchController
        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
        self.tabBarController?.navigationItem.title = "Movies"
        setUpInitialMovies()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier{
            if let destination = segue.destination as? MovieDetailViewController {
                destination.movie = sender as? Movie
            }
        }
    }
    
    func setUpInitialMovies(){
        for (index, _) in self.moviesArray.enumerated(){
            self.moviesArray[index].setGenreString(self.genres)
            self.moviesArray[index].isFavorite = DefaultsManager.shared.isMovieFavorite(self.moviesArray[index])
        }
        self.movieGridCollectionView.reloadData()
    }
    
    func setUpNewBatchOfMovies(){
        var newIndexes: [IndexPath] = []
        for (index, _) in self.moviesArray.enumerated(){
            self.moviesArray[index].setGenreString(self.genres)
            self.moviesArray[index].isFavorite = DefaultsManager.shared.isMovieFavorite(self.moviesArray[index])
            if index > currentLastIndex {
                let newIndexPath = IndexPath(item: index, section: 0)
                newIndexes.append(newIndexPath)
            }
        }
        movieGridCollectionView.performBatchUpdates({
            self.movieGridCollectionView.insertItems(at: newIndexes)
        }, completion: nil)
        isLoadingNextPage = false
        //movieGridCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func getNextPage(){
        currentPage += 1
        if currentPage <= maxPages {
            isLoadingNextPage = true
            let network = NetworkAPIManager()
            let params = ["api_key":network.apiKey,"page":currentPage,"language":locale ?? "en-US"] as [String : Any]
            network.request(urlString: "movie/popular", params: params){
                (response: GenericPagedMovieResponse?, error: ErrorTypes?) in
                if let error = error {
                    let alert = UIAlertController(title: NSLocalizedString("errors.generic", comment: ""), message: NSLocalizedString(error.message, comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if let array = response?.results {
                        self.moviesArray.append(contentsOf: array)
                        self.originalArray = self.moviesArray
                        self.setUpNewBatchOfMovies()
                    }
                }
            }
        }
    }
        
}
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell {
            cell.viewModel = MovieCollectionViewCell.ViewModel(moviesArray[indexPath.item])
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: moviesArray[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (moviesArray.endIndex - 1) == indexPath.item && !isSearching{
            currentLastIndex = moviesArray.endIndex - 1
            getNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as? LoadingCollectionReusableView{
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoadingNextPage {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize.zero
        }
    }
    
}
extension MovieCollectionViewCell.ViewModel{
    init(_ movie: Movie){
        id = movie.id
        imagePath = movie.poster_path
        title = movie.title
        isFavorite = movie.isFavorite ?? false
    }
}
extension MoviesViewController: ErrorViewDelegate{
    func buttonAction(_ erroView: ErrorView) {
        loadGenresAndMovies()
        erroView.hideErrorView()
    }
}
extension MoviesViewController: MovieCollectionViewCellDelegate{
    func favoriteAction(id: Int) {
        if let movieIndex = moviesArray.firstIndex(where: {$0.id == id}){
            moviesArray[movieIndex].setFavorite()
            movieGridCollectionView.reloadItems(at: [IndexPath(item: movieIndex, section: 0)])
        }
    }
    
}
extension MoviesViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, searchString != "" {
            isSearching = true
            moviesArray = originalArray.filter({
                (movie: Movie) -> Bool in
                movie.original_title.contains(searchString) || movie.title.contains(searchString)
            })
            if moviesArray.count <= 0 {
                view.addSubview(emptySearchErrorView)
            } else {
                emptySearchErrorView.hideErrorView()
            }
        } else {
            isSearching = false
            moviesArray = originalArray
            emptySearchErrorView.hideErrorView()
        }
        movieGridCollectionView.reloadData()
    }
}
