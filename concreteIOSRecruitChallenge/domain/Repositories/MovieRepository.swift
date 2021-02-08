//
//  MovieRepository.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

class MovieRepository: NSObject, ConnectionProtocol {
    
    //MARK: Init
    
    init (delegate: RepositoryProtocol){
        self.delegate = delegate
    }
    
    //MARK: Global Variables
    
    var delegate: RepositoryProtocol?
    
    //MARK: Connection Management
    
    func getData(){
        URLConnection.init(self).connect("\(Constants.endpoint)/3/movie/popular", method: "GET", json: nil, params: ["api_key":Constants.api_key], headers: nil)
    }
    func setFromData(_ json: [String : AnyObject], _ url: String) {
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: (json as AnyObject), requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: url)
        }catch {
            print("Couldn't write file")
        }
        self.delegate?.success(json)
    }
    func errorFromRequest(_ url: String) {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: url) as? Data {
            self.delegate?.success(KeyedUnarchiver.unarchiveObject(with: data) as? [String:AnyObject] ?? [String:AnyObject]())
        }else{
            self.delegate?.error()
        }
    }
}
protocol RepositoryProtocol: class{
    func success(_ json: [String:AnyObject])
    func error()
}
