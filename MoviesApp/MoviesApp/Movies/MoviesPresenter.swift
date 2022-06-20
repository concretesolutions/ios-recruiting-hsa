//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

protocol MoviesPresenterDelegate: AnyObject{
    func presentMovies(movies:[Movie])
    func showError(error:Error)
}

typealias PresenterMovieDelegate = MoviesPresenterDelegate & UIViewController


// MARK: - Interactive with API y transform to model for the presenter to View
class MoviesPresenter{
    weak var delegate: PresenterMovieDelegate?
    let dateFormatter = DateFormatter()
    
    //MARK: - Set detelegate
    public func setViewDelegate(delegate: PresenterMovieDelegate){
        self.delegate = delegate
    }
    
    
    //MARK: - Get movies of API
    public func getMovies(search: String){
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let url = URL(string: APIUrl.moviesURL) else {return}
     
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.delegate?.showError(error: urlFail.fail)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
                var movies = try decoder.decode(Movies.self,from:data)
                
                //Send Information to View
                //Filter
                if search != "" {
                    movies.results = movies.results.filter( { (item: Movie) -> Bool
                        in

                        let stringMatch = item.title.lowercased().range(of:search.lowercased())
                        return stringMatch != nil ? true : false
                    })
                }
                FavoriteManager.setFavorite(movies: &movies.results)
                
                self.delegate?.presentMovies(movies:movies.results )
            }catch{
                print(error)
                self.delegate?.showError(error: error)
            }
        }
        
        task.resume()
        
    }
   
}
