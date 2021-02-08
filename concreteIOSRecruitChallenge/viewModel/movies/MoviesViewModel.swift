//
//  MoviesViewModel.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MoviesViewModel: NSObject, ConnectionProtocol {
    
    //MARK: Global Variables
    
    var delegate: ViewModelProtocol?
    
    //MARK: Custom init
    
    init(viewDelegate: ViewModelProtocol) {
        self.delegate = viewDelegate
    }
    
    //MARK: Connection Management
    
    func getData(){
        URLConnection.init(self).connect("\(Constants.endpoint)/3/movie/popular", method: "GET", json: nil, params: ["api_key":Constants.api_key], headers: nil)
    }
    func setFromData(_ json: [String : AnyObject]) {
        self.delegate?.success(json)
    }
    func errorFromRequest(_ json: [String : AnyObject]) {
        self.delegate?.error(json)
    }
}

