//
//  MovieViewController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class MovieViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                           UIScrollViewDelegate {

    // MARK: Outlet
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    

    // MARK: Properties
    var movieList: [Movie] = []
    var genresList: [Genres] = []
    var movieIndex: Int = 0
    var moviePage: Int = 1
    var moviePageMax: Int = 34179
    
    let favouriteManager = FavouriteManager.shared
    let api: TheMovieAPIRest = TheMovieAPIRest()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        activityIndicator.startAnimating()
        api.listMovie(complete: didGetGenresMovie)
        favouriteManager.lists()
        api.popularMovie(page: moviePage, maxPage: moviePageMax, complete: didGetPopularMovie)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }

    func didGetPopularMovie(_ status: APIStatusType, _ response : PopularMovieResponse?) {
        print("Callback didGetPopularMovie")
        print("code    : \(status)")

        activityIndicator.stopAnimating()
        if status == .success {
            response?.results.forEach { movieData in
                movieList.append(Movie(name: movieData.title, image: "https://image.tmdb.org/t/p/w500/\(movieData.posterPath)", favorite: false, releaseDate: movieData.releaseDate ?? "-", synopsis: movieData.overview, genreIDS: movieData.genreIDS))
            }
            movieCollectionView.reloadData()
            print("Cantidad de películas: \(movieList.count)")
            //print("Películas: \(movieList)")
        } else {
            if moviePage == 1 {
                errorAlertMessage("No fue posible obtener el listado de películas populares")
            } else {
                errorAlertMessage("No fue posible obtener la siguiente lista de películas populares")
            }
            
        }
    }

    func didGetGenresMovie(_ status: APIStatusType, _ response : ListMovieResponse?) {
        print("Callback didGetGenresMovie")
        print("code    : \(status)")
    
        //activityIndicator.stopAnimating()
        if status == .success {
            response?.genres.forEach { genresData in
                genresList.append(Genres(id: genresData.id, name: genresData.name))
            }
            print("Cantidad de géneros de películas: \(genresList.count)")
        } else {
            errorAlertMessage("No fue posible obtener el list de películas")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.nameMovieLabel.text = movieList[indexPath.row].name
        if let urlImage = URL(string: movieList[indexPath.row].image) {
            cell.photoMovieImageView.load(url: urlImage)
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
 
        print("llamar a segue")
        let movieSelected: Int = Int(indexPath[1])
       
        performSegue(withIdentifier: "detailMovieSegue", sender: movieSelected)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          if (indexPath.row == movieList.count - 1 ) { //it's your last cell
            //Load more data & reload your collection view
              activityIndicator.startAnimating()
              moviePage += 1
              api.popularMovie(page: moviePage, maxPage: moviePageMax, complete: didGetPopularMovie)
          }
     }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("segue: \(segue.identifier)")
        switch segue.identifier {
            case "detailMovieSegue":
            
                if let detailMovieViewController = segue.destination as? DetailMovieViewController, let movieSelected = sender as? Int {
                    print("index selected: \(movieSelected)")
                    detailMovieViewController.imageMovie = movieList[movieSelected].image
                    detailMovieViewController.nameMovie = movieList[movieSelected].name
                    detailMovieViewController.releaseYear = movieList[movieSelected].releaseDate
                    detailMovieViewController.movieGenre = movieList[movieSelected].synopsis
                    detailMovieViewController.synopsys = movieList[movieSelected].synopsis
                    
                }
         default:
             print("segue no identificado")
         }
    }
}
