//
//  MoviesViewModel.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MoviesViewModel: NSObject, RepositoryProtocol {
    
    //MARK: Global Variables
    
    var delegate: MovieViewModelProtocol?
    var movieRepository: MovieRepository?
    
    //MARK: Custom init
    
    init(viewDelegate: MovieViewModelProtocol) {
        self.delegate = viewDelegate
    }
    func getData(params: [String : String]){
        self.movieRepository = MovieRepository(delegate: self)
        self.movieRepository?.getData(params: params)
    }
    
    //MARK: Repository Management
    
    func success(_ json: [String : AnyObject]) {
        self.delegate?.success(GeneralHeaderEntry<MovieEntry>.arrayFromJson(json))
    }
    func error() {
        self.delegate?.error()
    }
}
protocol MovieViewModelProtocol: class{
    func success(_ json: GeneralHeaderEntry<MovieEntry>?)
    func error()
}

