//
//  MoviesViewModel.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MoviesViewModel: NSObject, ConnectionProtocol {
    
    //MARK: Global Variables
    
    var delegate: MovieViewModelProtocol?
    
    //MARK: Custom init
    
    init(viewDelegate: MovieViewModelProtocol) {
        self.delegate = viewDelegate
    }
    
    //MARK: Connection Management
    
    func getData(){
        URLConnection.init(self).connect("\(Constants.endpoint)/3/movie/popular", method: "GET", json: nil, params: ["api_key":Constants.api_key], headers: nil)
    }
    func setFromData(_ json: [String : AnyObject]) {
        self.delegate?.success(GeneralHeaderEntry<MovieEntry>.arrayFromJson(json))
    }
    func errorFromRequest(_ json: [String : AnyObject]) {
        self.delegate?.error(json)
    }
}
protocol MovieViewModelProtocol: class{
    func success(_ json: GeneralHeaderEntry<MovieEntry>?)
    func error(_ json: [String:AnyObject])
}

