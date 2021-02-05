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
        self.refreshControl.beginRefreshing()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: Bundle(for: MovieCollectionViewCell.self)), forCellWithReuseIdentifier: "movieIdentifier")
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10.0, height: 270.0)
    }
}


//MARK: - Display Logic

extension MoviesViewController: PresenterToViewMoviesProtocol {
    func fetchMoviesSuccessfull(_ movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.refreshControl.endRefreshing()
    }
}
