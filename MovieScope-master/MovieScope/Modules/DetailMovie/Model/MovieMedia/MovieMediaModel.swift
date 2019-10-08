//
//  MovieMediaModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class MovieMediaModel{
    var movieVideos: MovieVideoModel?
    var movieImages: MovieImagesModel?
}

protocol MovieMediaConfigurableCell{
    func updateInfo(viewModel: MovieMediaViewModel)
}

protocol MovieMediaViewModel {}
