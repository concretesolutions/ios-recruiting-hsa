//
//  HomeViewModel.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 09-02-21.
//

import UIKit

class HomeViewModel: NSObject, RepositoryProtocol {
    
    //MARK: Global Variables
    
    var delegate: GenreProtocol?
    var genreRepository: GenreRepository?
    
    //MARK: Custom init
    
    init(viewDelegate: GenreProtocol) {
        self.delegate = viewDelegate
    }
    func getData(){
        self.genreRepository = GenreRepository(delegate: self)
        self.genreRepository?.getGeres()
    }
    
    //MARK: Repository Management
    
    func success(_ json: [String : AnyObject]) {
        self.delegate?.success(GenreEntry.arrayFromJson(json))
    }
    func error() {
        self.delegate?.error()
    }
}
protocol GenreProtocol: class{
    func success(_ json: [GenreEntry]?)
    func error()
}
