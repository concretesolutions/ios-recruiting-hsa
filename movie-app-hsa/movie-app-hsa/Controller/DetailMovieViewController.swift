//
//  DetailMovieViewController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class DetailMovieViewController: BaseViewController {


    // MARKER: Outlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameMoviewLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var favoriteSelectedBarButtonItem: UIBarButtonItem!
    
    var idMovie: Int = 0
    var imageMovie: String = ""
    var nameMovie: String = ""
    var releaseYear: String = ""
    var movieGenre: String = ""
    var synopsys: String = ""
    var selectedFavorite: Bool = false
    
    let favouriteManager = FavouriteManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        favouriteManager.lists()
        nameMoviewLabel.text = nameMovie
        releaseYearLabel.text =  releaseYear
        movieGenreLabel.text =  movieGenre
        synopsisLabel.text = synopsys
        
        if selectedFavorite {
            if let image = UIImage(systemName: "heart.fill") {
                favoriteSelectedBarButtonItem.image = image
            }
        } else {
            if let image = UIImage(systemName: "heart") {
                favoriteSelectedBarButtonItem.image = image
            }
        }
        if let urlImage = URL(string: imageMovie) {
            photoImageView.load(url: urlImage)
        }
        activityIndicator.stopAnimating()
    }
    
    @IBAction func favoriteSelectedBarButtomItem(_ sender: Any) {
        if selectedFavorite {
            if let image = UIImage(systemName: "heart") {
                favoriteSelectedBarButtonItem.image = image
            }
            let favourite: Favourite = Favourite(id: idMovie, name: nameMovie, image: imageMovie, releaseDate: releaseYear, synopsis: synopsys)
            favouriteManager.remove(favourite: favourite)
            
            selectedFavorite = false
        } else {
            if let image = UIImage(systemName: "heart.fill") {
                favoriteSelectedBarButtonItem.image = image
            }
            let favourite: Favourite = Favourite(id: idMovie, name: nameMovie, image: imageMovie, releaseDate: releaseYear, synopsis: synopsys)
            favouriteManager.add(favourite: favourite)
            selectedFavorite = true
        }
    }
}
