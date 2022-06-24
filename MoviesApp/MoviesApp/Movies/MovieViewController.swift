//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

// MARK: - UI About the Show Grid of Movies
class MovieViewController: UIViewController, MoviesPresenterDelegate {
    var movies: [Movie] = []
    let presenter = MoviesPresenter()
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    private var numberOfItemsPerSection = 9

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesSearchBar.delegate = self

        presenter.setViewDelegate(delegate: self)
        presenter.getMovies(search: "")
        navigationController?.navigationBar.backgroundColor = UIColor(named: ColorsMovie.Yellow)
        tabBarController?.tabBar.backgroundColor = UIColor(named: ColorsMovie.Yellow)
    }

    func presentMovies(movies: [Movie]) {
        self.movies = movies

        DispatchQueue.main.async {
            self.removeSpinner()
            if self.movies.count == 0 {
                self.moviesCollectionView.reloadData()
                AlertMovie.showBasicAlert(in: self,
                                          title: AlertConstant.Error,
                                          message: AlertConstant.ErrorMissingInfo + self.moviesSearchBar.text!,
                                          imageName: "Search")
            } else {
                self.moviesCollectionView.reloadData()
            }
        }

    }

    func showError(error: Error) {
        AlertMovie.showBasicAlert(in: self, title: AlertConstant.Error, message: error.localizedDescription)
    }
}

// MARK: - Set Collection View with Images
extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
                        -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movieCell, for: indexPath)
                as? MovieCollectionViewCell {
            let movie = movies[indexPath.row]
            cell.configurate(movie: movie)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt  indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: StoryBoardsIDS.idDetailMovie )
        as? DetailMovieViewController
        let movieSelect = movies[indexPath.row]
        detail?.movie = movieSelect

        print("Cell \(indexPath.row + 1) clicked")
        self.navigationController?.pushViewController(detail!, animated: true)
      }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        print("OffSetY: \(offsetY) contentHeight:\(contentHeight) ")
        if offsetY > contentHeight - scrollView.frame.size.height {
            print("this is end, see you in console")
            moviesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                              at: .bottom,
                                              animated: false)
        } else if offsetY < 0 {
            moviesCollectionView.scrollToItem(at: IndexPath(item: movies.count-1, section: 0),
                                              at: .top,
                                              animated: false)
        }
    }

}

// MARK: - Find by title
extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if !self.isRunning() {
            self.showSpinner()
        }
        presenter.getMovies(search: moviesSearchBar.text!)
    }
}
