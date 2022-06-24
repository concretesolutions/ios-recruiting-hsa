//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

// MARK: - UI About the Show Grid of Movies
class MoviesViewController: UIViewController, MoviesPresenterDelegate {
    private var movies: [Movie] = []
    private let presenter = MoviesPresenter()
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

      //
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        presenter.setViewDelegate(delegate: self)
        presenter.getMovies(search: "")
    }

    func presentMovies(movies: [Movie]) {
        self.movies = movies

        DispatchQueue.main.async {
            //
            self.moviesCollectionView.reloadData()
        }
    }
}

// MARK: - Set Collection View with Images
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
                -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movieCell, for: indexPath)
            as? MovieCollectionViewCell {
            cell.title.text = movies[indexPath.row].title
            return cell
        }
        return UICollectionViewCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt  indexPath: IndexPath) -> CGSize {
        let collectionViewWith = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let spaceBetweenCells = flowLayout.minimumInteritemSpacing
            let adjustWidth = collectionViewWith - spaceBetweenCells
            let width: CGFloat = adjustWidth / 2
            let height: CGFloat = 100
            return CGSize(width: width, height: height)
        }
    }
}
