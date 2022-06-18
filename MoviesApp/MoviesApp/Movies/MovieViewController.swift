//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

// MARK: - UI About the Show Grid of Movies
class MovieViewController: UIViewController,MoviesPresenterDelegate {
      
    var movies:[Movie] = []
    let presenter = MoviesPresenter()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesSearchBar.delegate = self

        presenter.setViewDelegate(delegate: self)
        presenter.getMovies(search: "")
        indicatorLoading.startAnimating()
    }
    
    
    func presentMovies(movies: [Movie]) {
        self.movies = movies
        
        DispatchQueue.main.async {
            
            if self.movies.count == 0 {
                AlertMovie.showBasicAlert(in:self, title: AlertConstant.Error, message: AlertConstant.ErrorMissingInfo + self.moviesSearchBar.text!)
            }
            
            self.moviesCollectionView.reloadData()
            self.indicatorLoading.stopAnimating()
        }

    }
    
    func showError(error: Error) {
        AlertMovie.showBasicAlert(in:self, title: AlertConstant.Error, message: error.localizedDescription)
    }
    
}


// MARK: - Set Collection View with Images
extension MovieViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movieCell, for: indexPath) as! MovieCollectionViewCell
        
        cell.title.text = movies[indexPath.row].title
        //Buscar bien la ruta completa dela imagen
       
        //cell.poster.loadFrom(URLAddress: APIUrl.routeImage + (movies[indexPath.row].poster_path))
        
        cell.poster.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500/neMZH82Stu91d3iqvLdNQfqPPyl.jpg")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt  indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView,
      didSelectItemAt indexPath: IndexPath) {
        
        //let detail:DetailMovieViewController = DetailMovieViewController()
    
        let detail = storyboard?.instantiateViewController(withIdentifier:StoryBoardsIDS.idDetailMovie ) as? DetailMovieViewController
        
        let movieSelect = movies[indexPath.row]
        detail?.movie = movieSelect
        
        print("Cell \(indexPath.row + 1) clicked")
        self.navigationController?.pushViewController(detail!, animated: true)
      }
    
}


//MARK: - Find by title

extension MovieViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            indicatorLoading.startAnimating()
            presenter.getMovies(search: moviesSearchBar.text!)
        
    }
}
