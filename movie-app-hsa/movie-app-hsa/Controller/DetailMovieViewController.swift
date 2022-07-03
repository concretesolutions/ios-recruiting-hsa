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
    
    var imageMovie: String = ""
    var nameMovie: String = ""
    var releaseYear: String = ""
    var movieGenre: String = ""
    var synopsys: String = ""
    
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
        
        if let urlImage = URL(string: imageMovie) {
            photoImageView.load(url: urlImage)
        }
        activityIndicator.stopAnimating()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
