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
    var genres: [Genre] = []
    @IBOutlet weak var movieGridCollectionView: UICollectionView!{
        didSet{
            movieGridCollectionView.dataSource = self
            movieGridCollectionView.delegate = self
        }
    }
    
    var currentPage: Int = 1
    var maxPages: Int = 1
    var currentLastIndex: Int = 0
    
    let cellIdentifier = "MovieGridCollectionViewCell"
    let footerIdentifier = "loadingFooter"
    let detailSegueIdentifier = "ShowMovieDetail"
    
    let locale = NSLocale.current.languageCode
    
    let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Movies"
        loadGenresAndMovies()
        print("Language: \(locale)")
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
        setUpInitialMovies()
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
        //self.movieGridCollectionView.reloadData()
    }
    
    func getNextPage(){
        currentPage += 1
        if currentPage <= maxPages {
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
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: moviesArray[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (moviesArray.endIndex - 1) == indexPath.item {
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    }
    
}
extension MovieCollectionViewCell.ViewModel{
    init(_ movie: Movie){
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
protocol Localizable {
    var localized: String { get }
}
extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
extension UITabBarItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}
