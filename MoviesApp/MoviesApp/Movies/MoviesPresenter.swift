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


class MoviesPresenter{
    weak var delegate: PresenterDelegate?
    
    public func getMovies(search: String){
        guard let url = URL(string: APIUrl.moviesURL) else {return}
     
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let movies = try JSONDecoder().decode(Movies.self,from:data)
                self.delegate?.presentMovies(movies: movies.results)
            }catch{
                print(error)
            }
        }.resume()
        
        
        
    }
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
}
