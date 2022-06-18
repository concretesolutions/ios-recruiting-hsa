//
//  DetailMovieViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

//MARK: - Detail of View Movie Controller
class DetailMovieViewController: UIViewController {

    @IBOutlet weak var posterImagen: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var sinopsisLabel: UITextView!
    @IBOutlet weak var generoLabel: UILabel!
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigure()
    }
    
    
    func setConfigure(){
        //Buscar bien la ruta completa dela imagen
       
        //cell.poster.loadFrom(URLAddress: APIUrl.routeImage + (movies[indexPath.row].poster_path))
        
        posterImagen.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500/neMZH82Stu91d3iqvLdNQfqPPyl.jpg")
        titleLabel.text = movie?.title
        yearLabel.text = movie?.release_date.description
        generoLabel.text = ""
        sinopsisLabel.text = movie?.overview
    }


}
