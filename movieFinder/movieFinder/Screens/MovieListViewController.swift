//
//  MovieListViewController.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 29-09-22.
//

import Foundation
import UIKit
import RealmSwift

// MARK: Move to separate files
class MovieListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private let sectionInsets = UIEdgeInsets(
      top: 20.0,
      left: 20.0,
      bottom: 20.0,
      right: 20.0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [RealmMovieItem]()
        
    private let itemsPerRow: CGFloat = 2
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        let urlString = "https://image.tmdb.org/t/p/w185" + "\(movies[indexPath.row].posterImageURL)"

        // MARK: move to a helper function
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "movieDetailVC") as! MovieDetailViewController
        nextVC.movieId = movies[indexPath.row].id

        self.navigationController?.show(nextVC, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        navigationController?.navigationBar.topItem?.title = "Movies"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        MovieAPI().getPopularMovies({result in
                self.movies = result
                self.collectionView.reloadData()
        });
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
      return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}
