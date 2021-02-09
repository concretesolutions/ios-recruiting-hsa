//
//  GenreRepository.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 09-02-21.
//

import UIKit

class GenreRepository: NSObject, ConnectionProtocol {
    
    //MARK: Global Variables
    
    var delegate: RepositoryProtocol?
    
    //MARK: Init
    
    init (delegate: RepositoryProtocol){
        self.delegate = delegate
    }
    
    //MARK: Connection Management
    
    func getGeres(){
        URLConnection.init(self).connect("\(Constants.endpoint)/3/genre/movie/list", method: "GET", json: nil, params: ["api_key":Constants.api_key], headers: nil)
    }
    func setFromData(_ json: [String : AnyObject], _ url: String) {
        self.delegate?.success(json)
    }
    func errorFromRequest(_ url: String) {
        self.delegate?.error()
    }
}
