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
import CoreData

class MovieViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultView: UIView!
    
    var searchController: UISearchController!
    var candies = [Any]()
    var pageMovie = 1
    var list = [Movie]()
    var dirtyList = [Movie]()
    var movieSelected : Movie?
    var movieBD : MovieEntity?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.isTranslucent = true
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = Tools.sharedInstance.getYelloAppColor()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.topItem?.title = "Movie"
        resultView.isHidden = true
        callMovieFromService(page: String(pageMovie))        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieCollectionView.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieDetail = segue.destination as! MovieDetailViewController
        movieDetail.movieID = movieSelected?.movieID
        
    }
    
    //MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //movieCellIdentifier
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellIdentifier", for: indexPath) as! MovieCollectionViewCell
        let movie = list[indexPath.row]
        
        movieCell.movieFavoriteButton.tag = indexPath.row
        movieCell.movieFavoriteButton.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
        
        verifyMovieIsFavorite(movie : movie)
        if movieBD != nil {
            movie.movieIsFavorite = true
        } else {
            movie.movieIsFavorite = false
        }
        
        movieCell.loadCell(picture: movie.movieBackdropPath, title: movie.movieTitle, isFavorite: movie.movieIsFavorite)
        
        
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
    
    //MARK: - SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            list = dirtyList
        } else {
            filterListBySearch(searchText : searchBar.text!)
        }
        searchBar.resignFirstResponder()
        movieCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            list = dirtyList
            
            //searchBar.resignFirstResponder()
            movieCollectionView.reloadData()
            
        }
    }
    
    //MARK: - Action
    @objc func favoriteBtnPressed(sender : UIButton!) {
        let movie = list[sender.tag]
        verifyMovieIsFavorite(movie: movie)
        if let movieSaved = movieBD {
            list[sender.tag].movieIsFavorite = false
            context.delete(movieSaved)
            saveMovie()
        } else {
            let movieEntity = MovieEntity(context: context)
            movieEntity.id = movie.movieID
            movieEntity.title = movie.movieTitle
            movieEntity.overview = movie.movieOverview
            movieEntity.image = movie.moviePosterPath
            movieEntity.year = movie.movieReleaseDate
            saveMovie()
            list[sender.tag].movieIsFavorite = true
        }
       
        movieCollectionView.reloadData()
    }
    
    //MARK: - Private
    func callMovieFromService(page : String) {
        self.showLoader()
        APIManager.sharedInstance.getPopularMovies(page: page, onSuccess: { json in
            DispatchQueue.main.async {
                print(String(describing: json));
                let array = json["results"]
                for (_,subJson):(String, JSON) in array {
                    self.dirtyList.append(Movie(json: subJson))
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
    
    func filterListBySearch(searchText : String) {
        var auxList = [Movie]()
        
        for item in dirtyList {
            if item.movieTitle.lowercased().contains(searchText.lowercased()) {
                auxList.append(item)
            }
        }
        resultView.isHidden = !(auxList.count == 0)
        list = auxList
    }
    
    func saveMovie() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
    func verifyMovieIsFavorite(movie : Movie) {
        let request : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", movie.movieID)
        request.predicate = predicate
        
        do {
            let movies = try (context.fetch(request))
            movieBD = movies.count > 0 ? movies[0] : nil
    
        } catch {
            print("Error fetching data \(error)")
        }
    }
    

}
