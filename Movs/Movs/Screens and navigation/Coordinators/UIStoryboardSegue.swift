//
//  UIStoryboardSegue.swift
//  Movs
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
    func forward(movie: Movie?) {
        (destination as? MovieDetailsViewController)?.movie = movie
    }
}
