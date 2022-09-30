//
//  MovieListViewController.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 29-09-22.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        navigationController?.navigationBar.topItem?.title = "Movies"
    }
}
