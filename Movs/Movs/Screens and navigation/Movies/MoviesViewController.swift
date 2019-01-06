//
//  ViewController.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, Networked {
    var networkController: NetworkController?
    var dataSource: MoviesCollectionViewDataSource?
    @IBOutlet weak var collectionView: UICollectionView!
}

// MARK: -
extension MoviesViewController {
    func setUpView() {
        collectionView.registerNib(forCellClass: MovieCollectionViewCell.self)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = UISearchController(searchResultsController: FavoritesViewController())
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func fetchMovies(page: Int) {
        networkController?.fetchList(for: TMDBEndpoint.popularMoviesURL, page: page) { [weak self] (result: Result<List<Movie>>) in
            (try? result.get()).map {
                print("\($0.results.count)")
                self?.updateDataSource($0.results)
            }
        }
    }
}

// MARK: - CollectionView
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        fetchMovies(page: 1)
    }
}

// MARK: - DataSource
extension MoviesViewController {
    func updateDataSource(_ movies: [Movie]) {
        dataSource = MoviesCollectionViewDataSource(movies: movies)
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = 234, marginSpace: CGFloat = 12
        return CGSize(width: (collectionView.frame.width / 2) - marginSpace, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = 8
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
