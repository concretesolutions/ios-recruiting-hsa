//
//  MovieViewController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class MovieViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                           UIScrollViewDelegate, UISearchBarDelegate {

    // MARK: Outlet
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    // MARK: Properties
    var movieList: [Movie] = []
    var genresList: [Genres] = []
    var favoriteList: [Favourite] = []
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
        favoriteList = favouriteManager.setToArray()
        api.popularMovie(page: moviePage, maxPage: moviePageMax, complete: didGetPopularMovie)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieSearchBar.delegate = self
        favouriteManager.favoriteChangeOff()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if favouriteManager.favoriteChange {
            favoriteList = favouriteManager.setToArray()
            movieCollectionView.reloadData()
            favouriteManager.favoriteChangeOff()
        }
    }

    func didGetPopularMovie(_ status: APIStatusType, _ response : PopularMovieResponse?) {
        print("Callback didGetPopularMovie")
        print("code    : \(status)")

        activityIndicator.stopAnimating()
        if status == .success {
            response?.results.forEach { movieData in
                
                let releaseDate = movieData.releaseDate ?? "-"
                let year = releaseDate.components(separatedBy: ["-"]).filter({!$0.isEmpty})

                movieList.append(Movie(id: movieData.id, name: movieData.title, image: "https://image.tmdb.org/t/p/w500/\(movieData.posterPath)", favorite: false, releaseDate: year[0], synopsis: movieData.overview, genreIDS: movieData.genreIDS))
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
        
        cell.id = movieList[indexPath.row].id
        cell.name = movieList[indexPath.row].name
        cell.releaseDate = movieList[indexPath.row].releaseDate
        cell.synopsis = movieList[indexPath.row].synopsis
        cell.image = movieList[indexPath.row].image
        
        cell.nameMovieLabel.text = movieList[indexPath.row].name
        
        // favoriteList.fi
        
        if let favoriteElement = favoriteList.first(where: {$0.id == movieList[indexPath.row].id}) {
            cell.imageSelected = true
        } else {
            cell.imageSelected = false
        }
        
        if cell.imageSelected {
            if let image = UIImage(systemName: "heart.fill") {
                cell.favouriteButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "heart") {
                cell.favouriteButton.setImage(image, for: .normal)
            }
        }
        
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print (searchText)
       
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("segue: \(segue.identifier)")
        switch segue.identifier {
            case "detailMovieSegue":
            
                if let detailMovieViewController = segue.destination as? DetailMovieViewController, let movieSelected = sender as? Int {
                    
                    print("index selected: \(movieSelected)")
                    
                    favoriteList = favouriteManager.setToArray()
                    favouriteManager.favoriteChangeOff()
                    
                    if let favoriteElement = favoriteList.first(where: {$0.id == movieList[movieSelected].id}) {
                        detailMovieViewController.selectedFavorite = true
                    } else {
                        detailMovieViewController.selectedFavorite = false
                    }
                    var genreText: String = "-"
                    if movieList[movieSelected].genreIDS.count > 0 {
                        genresList.forEach{
                            genres in
                            if genres.id == movieList[movieSelected].genreIDS.first {
                                genreText  = genres.name
                            }
                        }
                    }
                    
                    detailMovieViewController.idMovie = movieList[movieSelected].id
                    detailMovieViewController.imageMovie = movieList[movieSelected].image
                    detailMovieViewController.nameMovie = movieList[movieSelected].name
                    detailMovieViewController.releaseYear = movieList[movieSelected].releaseDate
                    detailMovieViewController.movieGenre = genreText
                    detailMovieViewController.synopsys = movieList[movieSelected].synopsis
                    
                }
         default:
             print("segue no identificado")
         }
    }
}
