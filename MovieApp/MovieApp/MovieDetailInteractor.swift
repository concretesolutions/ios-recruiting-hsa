//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieDetailInteractorProtocol{
    func saveMovie(movie: Movie)
}


class MovieDetailInteractor{
    
   var presenter : MovieDetailPresenterProtocol?
    
    
    func AttachPresenter(presenter : MovieDetailPresenterProtocol){
        self.presenter = presenter
    }
    
    func deAttach(){
        self.presenter = nil
    }
    
}

extension MovieDetailInteractor : MovieDetailInteractorProtocol {
    func saveMovie(movie: Movie) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(movie,update: true)
        }
    }
}
