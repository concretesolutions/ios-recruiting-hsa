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
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
extension MovieViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movieCell, for: indexPath) as! MovieCollectionViewCell
        
        cell.title.text = movies[indexPath.row].title
        //cell.poster.loadFrom(URLAddress: APIUrl.routeImage + (movies[indexPath.row].poster_path))
        
        cell.poster.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500/neMZH82Stu91d3iqvLdNQfqPPyl.jpg")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt  indexPath: IndexPath) -> CGSize {
        
       /* let collectionViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustWidth = collectionViewWith - spaceBetweenCells
        let width: CGFloat = adjustWidth / 2
        let height: CGFloat = 100*/
        
        return CGSize(width: 200, height: 200)
    }
    
}
