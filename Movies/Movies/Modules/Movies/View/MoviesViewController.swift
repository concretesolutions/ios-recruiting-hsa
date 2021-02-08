//
//  MoviesViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import UIKit

class MoviesViewController: ViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Memory debug
    
    deinit {
        print("Movies vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: MoviesPresenter = MoviesPresenter()
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var search: SearchController!
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.fetchMovies()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    
    func setupUI() {
        self.collectionView.refreshControl = refreshControl
        self.collectionView.backgroundColor = .white
        self.refreshControl.beginRefreshing()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: Bundle(for: MovieCollectionViewCell.self)), forCellWithReuseIdentifier: "movieIdentifier")
        search = SearchController(searchResultsController: nil)
        search.awakeFromNib()
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }

}

//MARK: - Search Result Updating

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        self.refreshControl.beginRefreshing()
        if text == "" {
            self.presenter.fetchMovies()
            return
        }
        self.presenter.fetchMovies(with: text)
    }
    
}

//MARK: - Collection View

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieIdentifier", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.movie = self.movies[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        let vc = MovieDetailRouter.createModule(movie.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10.0, height: 270.0)
    }
}

//MARK: - Movie Collection View Delegate

extension MoviesViewController: MovieCollectionViewCellDelegate {
    func didStarMovie(_ movie: Movie) {
        self.presenter.starMovie(movie.id)
    }
}


//MARK: - Display Logic

extension MoviesViewController: PresenterToViewMoviesProtocol {
    
    //Al obtener las peliculas renderizar la grilla
    func fetchMoviesSuccessfull(_ movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    //Al obtener error levantar una alerta
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.refreshControl.endRefreshing()
    }
    
    func starMovieSuccessfull() {
        //TODO: Something
    }
}
