//
//  MovieViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 21/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class MovieViewController: BaseViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    var searchController: UISearchController!
    var candies = [Any]()
    var pageMovie = 1
    var list = [Movie]()
    var movieSelected : Movie?
    
    // MARK: - Lifecycke
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.topItem?.title = "Movie"
        
        
        callMovieFromService(page: String(pageMovie))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieDetail = segue.destination as! MovieDetailViewController
        movieDetail.movieID = movieSelected?.movieID
        
    }
    
    
    func callMovieFromService(page : String) {
        self.showLoader()
        APIManager.sharedInstance.getPopularMovies(page: page, onSuccess: { json in
            DispatchQueue.main.async {
                print(String(describing: json));
                let array = json["results"]
                for (_,subJson):(String, JSON) in array {
                    self.list.append(Movie(json: subJson))
                }
                self.movieCollectionView.reloadData()
                self.hideLoader()

            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    

}

extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}


extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //movieCellIdentifier
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellIdentifier", for: indexPath) as! MovieCollectionViewCell
        let movie = list[indexPath.row]
        movieCell.loadCell(picture: movie.movieBackdropPath, title: movie.movieTitle, isFavorite: false)
        
        return movieCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 , height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item \(indexPath.row)")
        movieSelected = list[indexPath.row]
        self.performSegue(withIdentifier: "showDetailMovieSegue", sender: self)
        
        
    }
}
