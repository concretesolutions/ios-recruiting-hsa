//
//  DetailPageViewController.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import UIKit

class DetailPageViewController: ViewController {

    //MARK: Oulets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameFilmLabel: UILabel!
    @IBOutlet weak var yearFilmLabel: UILabel!
    @IBOutlet weak var genreFilmLabel: UILabel!
    @IBOutlet weak var descriptionFilmLabel: UILabel!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    //MARK: Propertis
//    var posterImage: UIImageView!
    var urlPosterPath: String = ""
    var idMovie: Int = 0
    var favoriteFilms: [Favorites] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
    }
    
    //MARK: Action
    @IBAction func onTapAddFavorite(_ sender: Any) {
        let singleton = FavoritesManager.shared
        
        let id = idMovie
        let overview = descriptionFilmLabel.text ?? ""
        let posterPath = urlPosterPath
        let releaseDate = yearFilmLabel.text ?? ""
        let title = nameFilmLabel.text ?? ""
        
        let objMovie = Favorites(id: id, overiview: overview, posterPath: posterPath, releaseDate: releaseDate, title: title)
        singleton.addMovieFavorite(movies: objMovie)
        addFavoriteButton.isHidden = true
        
    }
     
    //MARK: Loading and get response api
    func loadDetails() {
        let API: ApiMovies = ApiMovies()
        API.getInfoMovie(movieId: idMovie, complete: getMovieSelect)
    }
    
    func getMovieSelect(_ status: ApiStatusEnum,_ response : MovieInformacionResponse?) {
        if status == .success {
            let poster_path = response?.poster_path
            urlPosterPath = "https://image.tmdb.org/t/p/w300\(poster_path!)"
//            posterImage.loadFrom(URLAddress: urlPosterPath)
            let backdrop_path  = response?.backdrop_path
            movieImageView.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w300\(backdrop_path!)")
            nameFilmLabel.text = response?.title
            yearFilmLabel.text = response?.release_date
            descriptionFilmLabel.text = response?.overview
                    
            guard let elements = response?.id else {
                errorAlertMessage("No fue posible obtener la lista de Peliculas")
                return
            }

            if elements == 0 {
                errorAlertMessage("No se han ingresado Peliculas")
                return
            }
                        
         } else {
         errorAlertMessage("Error al obtener la lista de Peliculas")
                   
         }
    }

}
