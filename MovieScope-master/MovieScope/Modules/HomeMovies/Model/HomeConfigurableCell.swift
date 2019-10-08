//
//  HomeConfigurableCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol HomeConfigurableCell: ConfigurableCell {
    var delegate: HomeMovieDelegate?{get set}
}
