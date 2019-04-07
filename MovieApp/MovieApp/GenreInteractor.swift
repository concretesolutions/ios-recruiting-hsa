//
//  GenreInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/7/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

protocol GenreInteractorProtocol{
    func onfetchGenres()
}

class GenreInteractor {
    
    weak private var presenter : MoviePresenterProtocol?
    
    
}
