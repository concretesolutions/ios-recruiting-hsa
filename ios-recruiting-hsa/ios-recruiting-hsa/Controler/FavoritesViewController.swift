//
//  FavoritesViewController.swift
//  ios-recruiting-hsa
//
//  Created by training on 29-06-22.
//

import UIKit

class FavoritesViewController: ViewController, UITableViewDataSource, UITableViewDelegate{
    
    

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMovie()
    }
    func getMovieByIndex ( index: Set<Movie>.Index) -> Movie {
        movieList[0]
    }
    
    func setUpMovie() {
        let api: APIService = APIService()
        api.getPolular(complete: didGetMovies)
       
    }
    func didGetMovies(_ status: APIStatusType, _ response : MovieResponse?) {
        if status == .success {
            
            guard let cantElements = response?.results.count else {
                errorAlertMessage("No fue posible obtener la lista de Peliculas")
                return
            }
            
            if cantElements == 0 {
                
                errorAlertMessage("No se han ingresado Peliculas")
                return
            }
                response?.results.forEach{ movies in
                    movieList.append(Movie(adult: movies.adult
                                           ,backdropPath : movies.backdropPath
                                           ,genreIDS: movies.genreIDS
                                           ,id : movies.id
                                           ,originalLanguage : movies.originalLanguage
                                           ,originalTitle : movies.originalTitle
                                           ,overview : movies.overview
                                           ,popularity : movies.popularity
                                           ,posterPath : movies.posterPath
                                           ,releaseDate : movies.releaseDate
                                           ,title : movies.title
                                           ,video : movies.video
                                           ,voteAverage : movies.voteAverage
                                           ,voteCount : movies.voteCount))
                    
                }
            
            favoriteTableView.dataSource = self
            favoriteTableView.delegate = self
            favoriteTableView.reloadData()
                
        } else {
            errorAlertMessage("Error al obtener la lista de Peliculas")
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell: FavoriteTableViewCell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        
        let backdrop_path  = self.movieList[indexPath.row].posterPath
        cell.movieImageView.loadFrom(URLAddress: IMAGE_URL + backdrop_path!)
        
        cell.titleLabel.text = self.movieList[indexPath.row].title
        cell.yearLabel.text = self.movieList[indexPath.row].releaseDate
        cell.overviewLabel.text = self.movieList[indexPath.row].overview
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movieList[indexPath.row].id
       
        performSegue(withIdentifier: "segueFavorite", sender: movie)
        
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFavorite"{
            if let controller = segue.destination as? DetalViewController{
                
                controller.idMovie = sender as! Int

            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
