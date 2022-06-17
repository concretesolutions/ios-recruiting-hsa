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
}


typealias PresenterDelegate = MoviesPresenterDelegate & UIViewController

// MARK: - Interactive with API y transform to model for the presenter to View
class MoviesPresenter{
    weak var delegate: PresenterDelegate?
    
    //MARK: - Get movies of API
    public func getMovies(search: String){
        guard let url = URL(string: APIUrl.moviesURL) else {return}
     
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let movies = try JSONDecoder().decode(Movies.self,from:data)
                //Send Information to View
                self.delegate?.presentMovies(movies: movies.results)
            }catch{
                print(error)
            }
        }
        
        task.resume()
        
    }
    //MARK: - Init Class
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
}
