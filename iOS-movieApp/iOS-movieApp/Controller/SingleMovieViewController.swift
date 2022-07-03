//
//  SingleMovieViewController.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 30-06-22.
//

import UIKit



class SingleMovieViewController: UIViewController {
    
    @IBOutlet weak var titleMovieLabel : UILabel!
    @IBOutlet weak var descriptionTextView : UITextView!
    @IBOutlet weak var anioLabel : UILabel!
    @IBOutlet weak var generoLabel : UILabel!
    @IBOutlet weak var pictureImageView : UIImageView!
    
    var Movie : MovieResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI(){
        
        //Llgua el id desde peliculasPopulares, y ahora hay que hacer un nuevo llamado a la api
        
        guard let movie = Movie else { return }
        
        titleMovieLabel.text = movie.title
        anioLabel.text = movie.release_date
        descriptionTextView.text = movie.overview
        
        pictureImageView.downloaded(from: Endpoints.images +  movie.poster_path )
        pictureImageView.contentMode = .scaleAspectFill        
           
    }
    


}
