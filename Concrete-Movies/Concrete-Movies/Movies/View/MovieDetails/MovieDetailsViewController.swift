//
//  MovieDetailsViewController.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteIndicatorIcon: UIImageView!
    
    var movieDetails: MovieDetailEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }

    private func prepare(){
        
    }

}
