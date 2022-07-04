//
//  HomePageViewController.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import UIKit
import Alamofire

class HomePageViewController: ViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    //MARK: Oulets
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    //MARK: Propertis
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
    }
    
    //MARK: Action
    @IBAction func onTapAddFavorite(_ sender: Any) {
    }
    
    func movieForIndex(index: Set<Movie>.Index) -> Movie {
        movies[0]
    }
    
    //MARK: Loading and get response api
    func loadInfo() {
        let API: ApiMovies = ApiMovies()
        API.getPolularMovie(complete: getInfo)
    }
    
    func getInfo(_ status: ApiStatusEnum, _ response : MovieResponse?) {
        if status == .success {
                    
            guard let elements = response?.results.count else {
                errorAlertMessage("No se puede cargar lista de Peliculas")
                return
            }
            
            if elements == 0 {
                
                errorAlertMessage("No se han ingresado Peliculas")
                return
            }
                response?.results.forEach { movie in
                    movies.append(Movie(adult: movie.adult, backdropPath : movie.backdropPath, genreIDS: movie.genreIDS, id : movie.id, originalLanguage : movie.originalLanguage, originalTitle : movie.originalTitle, overview : movie.overview, popularity : movie.popularity, posterPath : movie.posterPath, releaseDate : movie.releaseDate, title : movie.title, video : movie.video, voteAverage : movie.voteAverage, voteCount : movie.voteCount))
                    
                }
            
            MovieCollectionView.dataSource = self
            MovieCollectionView.delegate = self
            MovieCollectionView.reloadData()
                        
        } else {
            errorAlertMessage("no hay lista de Peliculas")
        }
    }
    
    //MARK: Functions CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let poster_path = self.movies[indexPath.row].posterPath
        cell.movieImageView.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w300\(poster_path!)")
        cell.nameFilmLabel.text = self.movies[indexPath.row].title
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row].id
        performSegue(withIdentifier: "segueMovie", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovie"{
            if let controller = segue.destination as? DetailPageViewController {
                controller.idMovie = sender as! Int
            }
        }
    }

}
