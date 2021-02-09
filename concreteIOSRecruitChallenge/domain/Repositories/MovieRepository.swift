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
    override init (){
    }
    
    //MARK: Global Variables
    
    var delegate: RepositoryProtocol?
    let defaults = UserDefaults.standard
    
    //MARK: Connection Management
    
    func getData(params: [String : String]?){
        var mutableParams = params ?? [String : String]()
        mutableParams["api_key"] = Constants.api_key
        URLConnection.init(self).connect("\(Constants.endpoint)/3/movie/popular", method: "GET", json: nil, params: mutableParams, headers: nil)
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
        if let data = self.defaults.object(forKey: url) as? Data {
            self.delegate?.success(KeyedUnarchiver.unarchiveObject(with: data) as? [String:AnyObject] ?? [String:AnyObject]())
        }else{
            self.delegate?.error()
        }
    }
    
    func addFavorite(movie: MovieEntry){
        do{
            if let movieId = movie.id {
                let data = try NSKeyedArchiver.archivedData(withRootObject: (movie.toJsonArray() as AnyObject), requiringSecureCoding: false)
                UserDefaults.standard.set(data, forKey: "favorite:\(movieId)")
                print("favorite:\(movieId) added")
                
                if let data = self.defaults.object(forKey: "favorites") as? Data {
                    var favorites = KeyedUnarchiver.unarchiveObject(with: data) as? [Int] ?? [Int]()
                    favorites = favorites.filter { $0 != movieId }
                    favorites.append(movieId)
                    
                    let data = try NSKeyedArchiver.archivedData(withRootObject: (favorites as AnyObject), requiringSecureCoding: false)
                    UserDefaults.standard.set(data, forKey: "favorites")
                } else {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: ([movieId] as AnyObject), requiringSecureCoding: false)
                    UserDefaults.standard.set(data, forKey: "favorites")
                }
            }
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func removeFavorite(id: Int) -> Bool{
        print("favorite:\(id) removed")
        self.defaults.removeObject(forKey: "favorite:\(id)")
        return true
    }
    func isFavorite(id: Int) -> Bool{
        return self.defaults.object(forKey: "favorite:\(id)") as? Data != nil ? true: false
    }
    func listFavorites() -> [MovieEntry?]{
        var array: [MovieEntry?] = []
        if let data = self.defaults.object(forKey: "favorites") as? Data {
            let json = KeyedUnarchiver.unarchiveObject(with: data) as? [Int] ?? [Int]()
            for movieId in json{
                if let dataMovie = self.defaults.object(forKey: "favorite:\(movieId)") as? Data {
                    let movieJson = KeyedUnarchiver.unarchiveObject(with: dataMovie) as? [String:AnyObject] ?? [String:AnyObject]()
                    array.append(MovieEntry(movieJson))
                }
            }
        }
        return array
    }
}
protocol RepositoryProtocol: class{
    func success(_ json: [String:AnyObject])
    func error()
}
