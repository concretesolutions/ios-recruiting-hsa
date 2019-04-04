//
//  ViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

protocol MovieViewProtocol{
    func showMovieProtocol()
}



class MovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension MovieViewController : MovieViewProtocol {
    func showMovieProtocol() {
        
    }
}

