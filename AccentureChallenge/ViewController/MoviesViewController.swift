//
//  MoviesViewController.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit
import SwiftyJSON
import NotificationBannerSwift
import RealmSwift

class MoviesViewController: BaseViewController {
    
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet var searchFooter: SearchFooter!
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0) // margenes
    let itemsPerRow: CGFloat = 2
    var movies: Results<Movie>!
    var filteredMovies: Results<Movie>!
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.keyboardDismissMode = .onDrag
        
        moviesSearchBar.delegate = self
        
        loadPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        movies = realm.objects(Movie.self)
        filteredMovies = movies
        moviesCollectionView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        loadPopularMovies()
//    }
    
    func loadPopularMovies() {
        
        _ = APIManager.sharedInstance.getPopularMovies(page: 1){ isSuccess, jsonResponse in
       
            if isSuccess {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                for element in jsonResponse!["results"].array! {
                    
                    let movie = Movie()
                    movie.id = element["id"].intValue
                    movie.name = element["title"].stringValue
                    movie.movieDescription = element["overview"].stringValue
                    movie.pictureURL = "https://image.tmdb.org/t/p/w500\(element["poster_path"].stringValue)"
                    movie.date = dateFormatter.date(from: element["release_date"].stringValue)!
                    
                    let genres = List<Genre>()
                    for genre in element["genre_ids"].array! {
                        
                        let movieGenre = self.realm.object(ofType: Genre.self, forPrimaryKey: genre.intValue)
                        genres.append(movieGenre!)
                        
                    }
                    
                    movie.genres = genres
                    
                    if let existingMovie = self.realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                        movie.isFavorite = existingMovie.isFavorite
                    }

                    try! self.realm.write {
                        
                        self.realm.add(movie, update: true)
                    }
                }
                self.filteredMovies = self.movies
                self.moviesCollectionView.reloadData()

            } else {
                
//                let banner = StatusBarNotificationBanner(title: "Loading data error. Trying again...", style: .danger)
//                banner.show()
//
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
//
//                    self.loadInitialData()
//
//                }
            }
        }
    }
}

extension MoviesViewController: MovieDetailViewControllerDelegate {
    
    func movieDetailDismiss() {
        
        moviesCollectionView.reloadData()
    }    
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty {
            
            filteredMovies = movies
            searchBar.resignFirstResponder()
            searchFooter.setNotFiltering()
            isFiltering = false
            
        } else {
            
            filteredMovies = movies?.filter("name CONTAINS[c] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredMovies.count, of: movies.count)
            isFiltering = true
        }
        
        moviesCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieSegue" {
            
            let destinationViewController = segue.destination as! MovieDetailViewController
            destinationViewController.movie = sender as! Movie
            destinationViewController.delegate = self
            
        }
    }
}

/*
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
        searchFooter.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: candies.count)
        return filteredCandies.count
    }
 
    searchFooter.setNotFiltering()
    return candies.count
 }
 
 */


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "movieSegue", sender: filteredMovies[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.movie = filteredMovies[indexPath.row]
        return cell
    }
}

extension MoviesViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem-1, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}



