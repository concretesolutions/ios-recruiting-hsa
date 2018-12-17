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
    var currentLastIndex: Int = 0
    
    let cellIdentifier = "MovieGridCollectionViewCell"
    let detailSegueIdentifier = "ShowMovieDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Movies"
        let network = NetworkAPIManager()
        
        let paramsGenres = ["api_key":network.apiKey] as [String : Any]
        network.request(urlString: "genre/movie/list", params: paramsGenres){
            (response: GenresResponse?) in
            if let array = response?.genres {
                self.genres = array
                if let favorites = self.tabBarController?.viewControllers?[1] as? FavoriteMoviesViewController{
                    favorites.genres = array
                }
                let params = ["api_key":network.apiKey,"page":self.currentPage] as [String : Any]
                network.request(urlString: "movie/popular", params: params){
                    (response: GenericPagedMovieResponse?) in
                    if let array = response?.results {
                        self.moviesArray = array
                        self.setUpInitialMovies()
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
        let network = NetworkAPIManager()
        currentPage += 1
        let params = ["api_key":network.apiKey,"page":currentPage] as [String : Any]
        network.request(urlString: "movie/popular", params: params){
            (response: GenericPagedMovieResponse?) in
            if let array = response?.results {
                self.moviesArray.append(contentsOf: array)
                self.setUpNewBatchOfMovies()
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
            cell.movie = moviesArray[indexPath.item]
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
    
}

