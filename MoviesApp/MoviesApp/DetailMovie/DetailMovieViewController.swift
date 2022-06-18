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
    let movieSelect: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



}
