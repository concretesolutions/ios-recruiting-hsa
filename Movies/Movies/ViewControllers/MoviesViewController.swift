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
                let params = ["api_key":network.apiKey,"page":1] as [String : Any]
                network.request(urlString: "movie/popular", params: params){
                    (response: GenericPagedMovieResponse?) in
                    if let array = response?.results {
                        self.moviesArray = array
                        self.setUp()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier{
            if let destination = segue.destination as? MovieDetailViewController {
                destination.movie = sender as? Movie
            }
        }
    }
    
    func setUp(){
        for (index, _) in self.moviesArray.enumerated(){
            self.moviesArray[index].setGenreString(self.genres)
            self.moviesArray[index].isFavorite = DefaultsManager().isMovieFavorite(self.moviesArray[index])
        }
        self.movieGridCollectionView.reloadData()
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
    
}

