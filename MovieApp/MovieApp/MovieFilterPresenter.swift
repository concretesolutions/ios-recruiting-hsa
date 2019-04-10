//
//  MovieFilterPresenter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/9/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import RealmSwift
import Crashlytics


protocol MovieFilterPresenterProcotol{
//    var router : MovieFilterRouterProcotol
//    var interactor : MovieFilterInteractorProcotol
    var view : FilterMovieViewProtocol? { get set }
    
    
    func fetchDataFilter()
    func fetchDataFilterSuccess()
}

class MovieFilterPresenter {
    var data : [String:[String]] = ["Date":[]]
    var view: FilterMovieViewProtocol?
    
    func attachView(view : FilterMovieViewProtocol){
        self.view = view
    }
    
    func deAttach(){
        self.view = nil
    }
    
    func fetchGenre(){
        data["Genres"] = GenreInteractor.shared.genresList.map{$0.name}
    }
    
    func fetchYears(){
        do {
            let realm = try Realm()
            let dateList = realm.objects(Movie.self).toArray(ofType: Movie.self).map{$0.releaseDate}
            data["Date"] = dateList.unique()
        } catch let error  {
            Crashlytics.sharedInstance().recordError(error)
            data["Date"] = []
        }
    }
    
}

extension MovieFilterPresenter : MovieFilterPresenterProcotol{
    
    func fetchDataFilterSuccess() {
        view?.showDataFilter(data: data)
    }
    
    func fetchDataFilter(){
        fetchYears()
        fetchDataFilterSuccess()
    }
   
    
    
    
}
