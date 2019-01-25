//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 22/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieIsFavoriteButton: UIButton!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
