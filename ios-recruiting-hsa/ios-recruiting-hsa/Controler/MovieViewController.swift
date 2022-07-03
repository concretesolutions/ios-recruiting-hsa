//
//  MovieViewController.swift
//  ios-recruiting-hsa
//
//  Created by training on 29-06-22.
//

import UIKit

class MovieViewController: ViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
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
            
            movieCollectionView.dataSource = self
            movieCollectionView.delegate = self
            movieCollectionView.reloadData()
                
        } else {
            errorAlertMessage("Error al obtener la lista de Peliculas")
        }
        
    }

    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let backdrop_path  = self.movieList[indexPath.row].posterPath
        cell.movieImageView.loadFrom(URLAddress: IMAGE_URL + backdrop_path!)
        cell.titleLabel.text = self.movieList[indexPath.row].title
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movieList[indexPath.row].id
       
        performSegue(withIdentifier: "segueMovie", sender: movie)
    }
    

        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovie"{
            if let controller = segue.destination as? DetalViewController{
                
                controller.idMovie = sender as! Int

            }
        }
    }
    

}